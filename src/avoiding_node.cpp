#include <cartbot/utility.h>
#include <cartbot/publish.h>

ros::Publisher vel_pub, target_pub, marker_arr_pub, speed_pub;
visualization_msgs::MarkerArray marker_arr;

/* PID Variable */
double err_x = 0, err_y = 0, err_r = 0;
double target_x, target_y;
double temp_x, temp_y;

/* Potential Field Variable */
double vpot_x = 0, vpot_y = 0;

/* ROS Parameter Variable*/
bool is_simulation;
double Kp_rel, Kp_att;
double min_dist, u_k;
double weight, wheel_radius, wheel_interval, base_range;
double max_err_x, max_err_y, max_err_r, kp_x, kp_y, kp_r, ki_x, ki_y, ki_r;
double avoid_time;
double target_r;
bool isadvanced;
bool mode;

/* Advanced Accompny System Variable*/
double pre_r, pre_theta;
double pre_pos_l, pre_pos_r, now_pos_l, now_pos_r;
double v_x, v_y;
ros::Time pre_time;

double avoid_cnt, change_cnt = 0;
bool change_flag = false;

bool getParameter(ros::NodeHandle &nh)
{
    if (!nh.getParam("is_simulation", is_simulation))
        return false;
    if (!nh.getParam("Kp_rel", Kp_rel))
        return false;
    if (!nh.getParam("Kp_att", Kp_att))
        return false;
    if (!nh.getParam("min_dist", min_dist))
        return false;
    if (!nh.getParam("wheel_radius", wheel_radius))
        return false;
    if (!nh.getParam("wheel_interval", wheel_interval))
        return false;
    if (!nh.getParam("weight", weight))
        return false;
    if (!nh.getParam("base_range", base_range))
        return false;
    if (!nh.getParam("isadvanced", isadvanced))
        return false;
    if (!nh.getParam("kp_x", kp_x))
        return false;
    if (!nh.getParam("ki_x", ki_x))
        return false;
    if (!nh.getParam("max_err_x", max_err_x))
        return false;
    if (!nh.getParam("kp_y", kp_y))
        return false;
    if (!nh.getParam("ki_y", ki_y))
        return false;
    if (!nh.getParam("max_err_y", max_err_y))
        return false;
    if (!nh.getParam("kp_r", kp_r))
        return false;
    if (!nh.getParam("ki_r", ki_r))
        return false;
    if (!nh.getParam("max_err_r", max_err_r))
        return false;
    if (!nh.getParam("u_k", u_k))
        return false;
    if (!nh.getParam("avoid_time", avoid_time))
        return false;
    if (!nh.getParam("target_r", target_r))
        return false;
    if (!nh.getParam("mode", mode))
        return false;
    return true;
}

std::pair<double, double> calcAccompanySystem(const cartbot::Current::ConstPtr &current, double t_x, double t_y)
{
    std::pair<double, double> vel_vector;
    double e_x, e_y, c_x, c_y;

    /* PID Control */
    e_x = t_x - current->x;
    e_y = t_y - current->y;

    if (abs(e_x) < 0.01)
        e_x = 0;

    if (abs(e_y) < 0.01)
        e_y = 0;

    err_x += e_x;
    err_y += e_y;

    if (abs(err_x) > max_err_x)
    {
        if (err_x > 0)
            err_x = max_err_x;
        else
            err_x = -max_err_x;
    }
    if (abs(err_y) > max_err_y)
    {
        if (err_y > 0)
            err_y = max_err_y;
        else
            err_y = -max_err_y;
    }
    if (!change_flag)
    {
        c_x = kp_x * e_x + ki_x * err_x; // pi control
        c_y = kp_y * e_y + ki_y * err_y; // pi control
        //c_x = -kp_x * current->x + ki_x * err_x; // ip control
        //c_y = -kp_y * current->y + ki_y * err_y; // ip control
    }
    else
    {
        c_x = kp_x / 1.2 * e_x + ki_x * err_x; // pi control
        c_y = kp_y / 1.2 * e_y + ki_y * err_y; // pi control
        //c_x = -kp_x / 1.2 * current->x + ki_x * err_x; // ip control
        //c_y = -kp_y / 1.2 * current->y + ki_y * err_y; // ip control
    }

    vel_vector.second = -(base_range / (base_range + t_x)) * c_y;
    vel_vector.first = -c_x + (t_y / base_range) * vel_vector.second;

    if(-2 * base_range - wheel_radius <= t_x < -base_range - wheel_radius)
    {
        vel_vector.second = -(base_range / (-base_range - wheel_radius)) * c_y;
        vel_vector.first = (-c_x + (t_y / base_range) * vel_vector.second) / 1.2;
    }
    else if(-base_range + wheel_radius < t_x <= wheel_radius)
    {
        vel_vector.second = -(base_range / (base_range + wheel_radius)) * c_y;
        vel_vector.first = (-c_x + (t_y / base_range) * vel_vector.second) / 1.2;
    }
    else if(-base_range - wheel_radius <= t_x <= -base_range + wheel_radius)
    {
        vel_vector.second = 0;
        vel_vector.first = -c_x / 1.5;
    }

    if(abs(vel_vector.second) > 1.5)
    {
        vel_vector.second / (abs(vel_vector.second) * 2.5);
        vel_vector.first / (abs(vel_vector.first) * 1.5);
    }

    publishHumanStl(marker_arr, current->x, current->y, atan2(current->vy, current->vx));
    publishCurrnetLine(marker_arr, 0, 0, current->x, current->y);

    return vel_vector;
}

std::pair<double, double> calcAdvacnedAccompanySystem(const cartbot::Current::ConstPtr &current, const double &dt, const double &vx, const double &vy, const double &omega, double t_x, double t_y, double te_x, double te_y)
{
    std::pair<double, double> vel_vector;
    double x0, y0, r, r_dot, theta, theta_dot, phi, err_theta;
    double u_x, u_y, e_x, e_y, c_x, c_y;

    r = sqrt(pow(current->x, 2) + pow(current->y, 2));
    theta = atan2(current->y, current->x);

    /* Calculate User Velocity */
    double err_r = r - pre_r;
    if (abs(err_r) < 0.01)
        err_r = 0;
    r_dot = err_r / dt;

    err_theta = theta - pre_theta;
    if (abs(err_theta) < DEG2RAD(0.05))
        err_theta = 0;
    theta_dot = err_theta / dt;

    u_x = vx + r_dot * cos(theta) - r * (omega + theta_dot) * sin(theta);
    u_y = vy + r_dot * sin(theta) + r * (omega + theta_dot) * cos(theta);

    if (abs(u_x) < 0.04)
        u_x = 0;
    if (abs(u_y) < 0.04)
        u_y = 0;

    if (u_x == 0 || u_y == 0)
    {
        phi = theta;
        x0 = -(current->x);
        y0 = -(current->y);

        vel_vector.first = 0;
        vel_vector.second = 0;
    }
    else
    {
        phi = atan2(u_y, u_x);
        x0 = te_x - r * cos(phi - theta);
        y0 = te_y + r * sin(phi - theta);

        /* PID Controller */
        e_x = t_x - x0;
        e_y = t_y - y0;

        if (abs(e_x) < 0.02)
            e_x = 0;

        if (abs(e_y) < 0.02)
            e_y = 0;

        err_x += e_x;
        err_y += e_y;

        if (abs(err_x) > max_err_x)
        {
            if (err_x > 0)
                err_x = max_err_x;
            else
                err_x = -max_err_x;
        }
        if (abs(err_y) > max_err_y)
        {
            if (err_y > 0)
                err_y = max_err_y;
            else
                err_y = -max_err_y;
        }

        if (!change_flag)
        {
            c_x = kp_x / 1.6 * e_x + ki_x * err_x;
            c_y = kp_y / 1.6 * e_y + ki_y * err_y;
        }
        else
        {
            c_x = kp_x / 1.6 / 1.2 * e_x + ki_x * err_x;
            c_y = kp_y / 1.6 / 1.2 * e_y + ki_y * err_y;
        }

        // c_x = kp_x * e_x + ki_x * err_x;
        // c_y = kp_y * e_y + ki_y * err_y;

        vel_vector.first = c_x * cos(phi) - c_y * sin(phi);
        vel_vector.second = c_x * sin(phi) + c_y * cos(phi);
    }

    publishCurrnetLine(marker_arr, current->x, current->y, x0, y0);
    publishHumanStl(marker_arr, current->x, current->y, phi);

    pre_r = r;
    pre_theta = theta;
    return vel_vector;
}

std::pair<double, double> calcLineAccompanySystem(const cartbot::Current::ConstPtr &current, double t_x, double t_y)
{
    std::pair<double, double> vel_vector;
    double e_r, c_r, r, theta, t_r;

    t_r = sqrt(pow(t_x, 2) + pow(t_y, 2));

    r = sqrt(pow(current->x, 2) + pow(current->y, 2));
    theta = atan2(current->y, current->x);

    /* PID Control */
    e_r = t_r - r;

    if (abs(e_r) < 0.01)
        e_r = 0;

    err_r += e_r;

    if (abs(err_r) > max_err_r)
    {
        if (err_r > 0)
            err_r = max_err_r;
        else
            err_r = -max_err_r;
    }
    if (!change_flag)
    {
        c_r = kp_r * e_r + ki_r * err_r;
    }
    else
    {
        c_r = kp_r / 1.2 * e_r + ki_r * err_r;
    }

    vel_vector.second = -sin(theta) * c_r;
    vel_vector.first = -cos(theta) * c_r;

    publishHumanStl(marker_arr, current->x, current->y, atan2(current->vy, current->vx));
    publishCurrnetLine(marker_arr, 0, 0, current->x, current->y);

    return vel_vector;
}

std::pair<double, double> calcRepulsivePotentialField(const double &x, const double &y, std::vector<cartbot::Cluster> objectlist)
{
    std::pair<double, double> force_vector(0, 0);
    for (auto &object : objectlist)
    {
        for (auto &point : object.points)
        {
            if (point.x > 0.0)
            {
                double dist, dist_x, dist_y;
                dist_x = point.x - x;
                dist_y = point.y - y;
                dist = sqrt(pow(dist_x, 2) + pow(dist_y, 2));
                if (min_dist >= dist)
                {
                    force_vector.first -= Kp_rel * (1 / dist - 1 / min_dist) * (1 / pow(dist, 2)) * (dist_x / dist);  // x_repulsive
                    force_vector.second -= Kp_rel * (1 / dist - 1 / min_dist) * (1 / pow(dist, 2)) * (dist_y / dist); // y_repulsive
                }
            }
        }
    }
    return force_vector;
}

std::pair<double, double> calcAttractivePotentialField(const double &tx, const double &ty, const double &nx, const double &ny)
{
    std::pair<double, double> force_vector;
    double e_x, e_y, dist;
    e_x = tx - nx;
    e_y = ty - ny;
    dist = sqrt(pow(e_x, 2) + pow(e_y, 2));
    force_vector.first = Kp_att * e_x / dist;  // x_attractive
    force_vector.second = Kp_att * e_y / dist; // y_attractive
    return force_vector;
}

bool isObstacleNear(const std::vector<cartbot::Cluster> objectlist)
{
    unsigned int object_cnt = 0;
    ROS_INFO("object num = %d", objectlist.size());
    for (auto &object : objectlist)
    {
        for (auto &point : object.points)
        {
            if (point.x > base_range / -1.7)
            {
                double dist, dist_x, dist_y;
                dist = sqrt(pow(point.x, 2) + pow(point.y, 2));
                if (min_dist >= dist)
                    return true;
            }
        }
    }
    return false;
}

void modeCallback(const std_msgs::Bool::ConstPtr& msg)
{
    mode = msg->data;
}

void currentCallback(const cartbot::Current::ConstPtr &current)
{
    std::pair<double, double> vel_vector, rep_force, att_force;
    geometry_msgs::Twist cmd_vel;
    cartbot::Speed speed;
    uint8_t state = current->state;
    double w_r, w_l;
    marker_arr.markers.clear();
    if (state == cartbot::Current::LOST || state == cartbot::Current::STOP)
    {
        err_x = 0;
        err_y = 0;
        v_x = 0;
        v_y = 0;
        vpot_x = 0;
        vpot_y = 0;
        if(is_simulation == false)
        {
            speed.tar_rpm_l = 0;
            speed.tar_rpm_r = 0;
            speed_pub.publish(speed);
        }
    }
    if (state == cartbot::Current::INIT)
    {
        if (isadvanced == true)
        {
            /* Advanced Accompany System */
            double r, theta, phi = 0;
            r = sqrt(pow(current->x, 2) + pow(current->y, 2));
            theta = atan2(current->y, current->x);
            target_x = current->x - r * cos(phi - theta);
            target_y = current->y + r * sin(phi - theta);
            temp_x = current->x;
            temp_y = current->y;

            pre_r = r;
            pre_theta = theta;
            pre_time = ros::Time::now();
            publishTargetLine(target_pub, current->x, current->y, target_x, target_y);
        }
        else
        {
            /* Accompany System */
            target_x = current->x;
            target_y = current->y;
            publishTargetLine(target_pub, 0, 0, current->x, current->y);
        }
    }
    if (state == cartbot::Current::TRACKING)
    {
        /* Time Calculation */
        ros::Time now_time = ros::Time::now();
        ros::Duration duration_t = now_time - pre_time;
        const double dt = duration_t.toSec();

        /* Velocity Calculation */
        double omega, vx, vy, err_pos_r, err_pos_l;

        err_pos_r = now_pos_r - pre_pos_r;
        if (abs(err_pos_r) < DEG2RAD(0.05))
            err_pos_r = 0;
        err_pos_l = now_pos_l - pre_pos_l;
        if (abs(err_pos_l) < DEG2RAD(0.05))
            err_pos_l = 0;

        w_r = err_pos_r / dt;
        w_l = err_pos_l / dt;

        omega = (wheel_radius / wheel_interval) * (w_r - w_l);
        vx = (wheel_radius / wheel_interval) * wheel_interval / 2 * (w_r + w_l);
        vy = base_range * omega;

        if (isObstacleNear(current->objects) == true)
        {
            if (avoid_cnt == 0)
                change_flag = true;
            avoid_cnt = avoid_time;
        }
        else
        {
            avoid_cnt -= dt;
            if (0 < avoid_cnt && avoid_cnt < 1.5)
                change_flag = true;
            if (avoid_cnt < 0)
                avoid_cnt = 0;
        }

        if (change_flag == true)
        {
            change_cnt += dt;
            if (change_cnt > 3.0)
            {
                change_flag = false;
                change_cnt = 0;
            }
        }

        if (avoid_cnt > 0)
        {
            if (target_x > 0)
            {
                const double r = target_r;
                /* Accompany System */
                if (isadvanced == true)
                {
                    vel_vector = calcAdvacnedAccompanySystem(current, dt, vx, vy, omega, r, 0, temp_x, temp_y);
                }
                else
                {
                    if (mode == true)
                    {
                        vel_vector = calcLineAccompanySystem(current, r, 0);
                    }
                    else
                    {
                        vel_vector = calcAccompanySystem(current, r, 0);
                    }
                    publishTargetLine(target_pub, 0, 0, r, 0);
                }
            }
        }
        else
        {
            /* Accompany System */
            if (isadvanced == true)
            {
                vel_vector = calcAdvacnedAccompanySystem(current, dt, vx, vy, omega, target_x, target_y, temp_x, temp_y);
            }
            else
            {
                if (mode == true)
                {
                    vel_vector = calcLineAccompanySystem(current, target_x, target_y);
                }
                else
                {
                    vel_vector = calcAccompanySystem(current, target_x, target_y);
                }
                publishTargetLine(target_pub, 0, 0, target_x, target_y);
            }
        }

        /* Potential Field */
        rep_force = calcRepulsivePotentialField(0, 0, current->objects);
        att_force = calcAttractivePotentialField(current->x, current->y, target_x, 0);

        if (abs(rep_force.first) > 0)
            vpot_x += rep_force.first + att_force.first / weight;
        if (abs(rep_force.second) > 0)
            vpot_y += rep_force.second + att_force.second / weight;

        if (abs(vpot_x) > 1.0)
        {
            if (vpot_x > 0)
                vpot_x = 1.0;
            else
                vpot_x = -1.0;
        }
        if (abs(vpot_y) > 1.0)
        {
            if (vpot_y > 0)
                vpot_y = 1.0;
            else
                vpot_y = -1.0;
        }

        if (abs(vpot_x) > 0)
        {
            if (vpot_x < 0)
            {
                vpot_x += u_k * weight;
                if (vpot_x > 0)
                    vpot_x = 0;
            }
            else
            {
                vpot_x -= u_k * weight;
                if (vpot_x < 0)
                    vpot_x = 0;
            }
        }
        if (abs(vpot_y) > 0)
        {
            if (vpot_y < 0)
            {
                vpot_y += u_k * weight;
                if (vpot_y > 0)
                    vpot_y = 0;
            }
            else
            {
                vpot_y -= u_k * weight;
                if (vpot_y < 0)
                    vpot_y = 0;
            }
        }

        publishForceVector(marker_arr, rep_force.first + att_force.first, rep_force.second + att_force.second);
        if (current->lost_cnt > 0)
        {
            v_x = 0;
            v_y = 0;
        }
        else
        {
            if (abs(rep_force.first) > 0)
                v_x = vel_vector.first + vpot_x;
            else
                v_x = vel_vector.first;
            if (abs(rep_force.second) > 0)
                v_y = vel_vector.second + vpot_y;
            else
                v_y = vel_vector.second;
        }

        pre_time = now_time;
        pre_pos_r = now_pos_r;
        pre_pos_l = now_pos_l;
    }
    if (is_simulation) /* Gazebo Sumulation geometry/twist msgs */
    {
        cmd_vel.linear.x = v_x;
        cmd_vel.angular.z = v_y / base_range;
        vel_pub.publish(cmd_vel);
    }
    else
    {
        w_l = (1 / wheel_radius) * v_x - ((wheel_interval / 2.0) / (wheel_radius * base_range)) * v_y;
        w_r = (1 / wheel_radius) * v_x + ((wheel_interval / 2.0) / (wheel_radius * base_range)) * v_y;
        speed.tar_rpm_l = static_cast<int>(RAD2RPM(w_l));
        speed.tar_rpm_r = static_cast<int>(RAD2RPM(w_r));
        speed_pub.publish(speed);
    }
    if (marker_arr.markers.size() > 0)
        marker_arr_pub.publish(marker_arr);
}

void encoderCallback(const sensor_msgs::JointState::ConstPtr &joint)
{
    now_pos_r = joint->position[0];
    now_pos_l = joint->position[1];
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "avoiding_node");
    ros::NodeHandle nh;
    if (!getParameter(nh))
    {
        ROS_ERROR_STREAM("Check avoiding node parameter");
        exit(0);
    }
    if (is_simulation)
        vel_pub = nh.advertise<geometry_msgs::Twist>("cmd_vel1", 1);
    else
        speed_pub = nh.advertise<cartbot::Speed>("avoid/speed", 1);
    ros::Subscriber mode_sub = nh.subscribe<std_msgs::Bool>("ui/message", 1, modeCallback);
    ros::Subscriber target_sub = nh.subscribe<cartbot::Current>("/track/current", 1, currentCallback);
    ros::Subscriber joint_sub = nh.subscribe<sensor_msgs::JointState>("/robot_1/joint_states", 1, encoderCallback);
    marker_arr_pub = nh.advertise<visualization_msgs::MarkerArray>("/avoid/marker_array", 1);
    target_pub = nh.advertise<visualization_msgs::Marker>("/avoid/target", 1);
    
    ROS_INFO("\033----> Avoiding Node Started.\033");
    ros::spin();
}