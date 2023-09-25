#include <cartbot/utility.h>
#include <cartbot/publish.h>
#include <cartbot/kalman_filter.h>

ros::Publisher x_comp_pub[4];
ros::Publisher y_comp_pub[4];
ros::Publisher estimate_pub;
ros::Publisher current_pub;
ros::Publisher status_pub;
ros::Time pre_time;

/* Kalman Filter Variable */
KalmanFilter kf;
Measurement m;
Estimation e;

bool islost = false;
unsigned int lost_cnt = 0;
State state = State::LOST;

/* ROS Param Variable */
double wait_time, stop_time;
double dist_threshold;
double min_range;

/* Initialization Variable */
double init_cnt = 0;
double init_x, init_y;
ros::Time init_time;
double stop_cnt = 0;

bool getParameter(ros::NodeHandle &nh)
{
    enum NAME_LIST
    {
        A,
        H,
        R,
        P,
        Q
    };
    Eigen::MatrixXd mat_A(4, 4);
    Eigen::MatrixXd mat_H(2, 4);
    Eigen::MatrixXd mat_R(2, 2);
    Eigen::MatrixXd mat_P(4, 4);
    Eigen::MatrixXd mat_Q(4, 4);
    XmlRpc::XmlRpcValue paramConfig;

    std::string mat_name[5] = {"A", "H", "R", "P", "Q"};
    for (int n = 0; n < 5; n++)
    {
        if (nh.hasParam(mat_name[n]))
        {
            try
            {
                nh.getParam(mat_name[n], paramConfig);
                ROS_ASSERT(paramConfig.getType() == XmlRpc::XmlRpcValue::TypeArray);
                for (int i = 0; i < 4; i++)
                {
                    for (int j = 0; j < 4; j++)
                    {
                        std::ostringstream ostr;
                        ostr << paramConfig[4 * i + j];
                        std::istringstream istr(ostr.str());
                        switch (n)
                        {
                        case NAME_LIST::A:
                            istr >> mat_A(i, j);
                            break;
                        case NAME_LIST::P:
                            istr >> mat_P(i, j);
                            break;
                        case NAME_LIST::Q:
                            istr >> mat_Q(i, j);
                            break;
                        }
                    }
                }
                for (int i = 0; i < 2; i++)
                {
                    for (int j = 0; j < 4; j++)
                    {
                        std::ostringstream ostr;
                        ostr << paramConfig[4 * i + j];
                        std::istringstream istr(ostr.str());
                        switch (n)
                        {
                        case NAME_LIST::H:
                            istr >> mat_H(i, j);
                            break;
                        }
                    }
                }
                for (int i = 0; i < 2; i++)
                {
                    for (int j = 0; j < 2; j++)
                    {
                        std::ostringstream ostr;
                        ostr << paramConfig[2 * i + j];
                        std::istringstream istr(ostr.str());
                        switch (n)
                        {
                        case NAME_LIST::R:
                            istr >> mat_R(i, j);
                            break;
                        }
                    }
                }
            }
            catch (...)
            {
                throw;
            }
        }
        else
        {
            return false;
        }
    }
    if (!nh.getParam("dist_threshold", dist_threshold))
        return false;
    if (!nh.getParam("min_range", min_range))
        return false;
    if (!nh.getParam("wait_time", wait_time))
        return false;
    if (!nh.getParam("stop_time", stop_time))
        return false;

    std::cout << "A : \n"
              << mat_A << std::endl;

    std::cout << "H : \n"
              << mat_H << std::endl;

    std::cout << "R : \n"
              << mat_R << std::endl;

    std::cout << "P : \n"
              << mat_P << std::endl;

    std::cout << "Q : \n"
              << mat_Q << std::endl;

    kf.initMatrix(mat_A, mat_H, mat_R, mat_P, mat_Q);
    return true;
}

double evaluateMeasurement(Estimation e, const double &x, const double &y, const double &dt)
{
    double error_x, error_y;
    double estimate_mx = e.pos[X] + e.vel[X] * dt;
    double estimate_my = e.pos[Y] + e.vel[Y] * dt;
    error_x = pow(abs(x - estimate_mx), 2);
    error_y = pow(abs(y - estimate_my), 2);
    return error_x + error_y;
}

void clusterlistCallback(const cartbot::ClusterArray::ConstPtr &clusterlist)
{
    cartbot::ClusterArray objectlist;
    cartbot::Current current;
    std_msgs::String status;
    switch (state)
    {
    case STOP:
    {
        ROS_INFO("STATE----> STOP");
        current.state = state;
        status.data = "STOP";
        ros::Time now_time = ros::Time::now();
        ros::Duration duration_t = now_time - pre_time;
        const double dt = duration_t.toSec();
        stop_cnt += dt;
        pre_time = now_time;
        if (stop_cnt > stop_time)
        {
            stop_cnt = 0;
            state = LOST;
        }
        break;
    }
    case LOST:
    {
        ROS_INFO("STATE----> OBJECT_LOST");
        current.state = state;
        status.data = "OBJECT_LOST";
        for (auto cluster : clusterlist->Clusters)
        {
            float dist = sqrt(pow(cluster.mid_x, 2) + pow(cluster.mid_y, 2));
            if (abs(dist) < dist_threshold)
            {
                init_cnt = 0;
                init_time = ros::Time::now();
                init_x = cluster.mid_x;
                init_y = cluster.mid_y;
                state = COUNT;
                break;
            }
        }
        break;
    }
    case COUNT:
    {
        ROS_INFO("STATE----> TIME_COUNTING");
        current.state = state;
        status.data = "TIME_COUNTING";
        islost = true;
        for (auto cluster : clusterlist->Clusters)
        {
            float dist = sqrt(pow(init_x - cluster.mid_x, 2) + pow(init_y - cluster.mid_y, 2));
            if (abs(dist) < 0.5)
            {
                ros::Duration duration_t = ros::Time::now() - init_time;
                init_cnt = duration_t.toSec();
                publishEstimationBox(estimate_pub, cluster.mid_x, cluster.mid_y, state);
                islost = false;
                init_x = cluster.mid_x;
                init_y = cluster.mid_y;
                break;
            }
        }
        if (islost)
        {
            state = LOST;
        }
        if (init_cnt > wait_time)
        {
            state = INIT;
        }
        break;
    }
    case INIT:
    {
        ROS_INFO("STATE----> TRACKING_INITIALIZATION");
        current.state = state;
        status.data = "TRACKING_INITIALIZATION";
        islost = true;
        for (auto cluster : clusterlist->Clusters)
        {
            float dist = sqrt(pow(init_x - cluster.mid_x, 2) + pow(init_y - cluster.mid_y, 2));
            if (abs(dist) < min_range)
            {
                Eigen::VectorXd xn(4);
                pre_time = cluster.Header.stamp;
                xn << cluster.mid_x, cluster.mid_y, 0, 0;
                kf.initValue(xn);
                current.x = cluster.mid_x;
                current.y = cluster.mid_y;
                updateEstimation(e, cluster.mid_x, cluster.mid_y, 0, 0);
                updateMeasurement(m, e.pos[X], e.pos[Y], 0.5);
                publishEstimationBox(estimate_pub, e.pos[X], e.pos[Y], state);
                state = TRACKING;
                islost = false;
            }
            else
            {
                current.objects.push_back(cluster);
            }
        }
        if (islost)
        {
            state = LOST;
        }
        break;
    }
    case TRACKING:
    {
        ROS_INFO("STATE----> TRACKING");
        current.state = state;
        status.data = "TRACKING";
        islost = true;
        std::vector<cartbot::Cluster> measure_list;
        for (auto cluster : clusterlist->Clusters)
        {
            float dist = sqrt(pow(cluster.mid_x - e.pos[X], 2) + pow(cluster.mid_y - e.pos[Y], 2));
            float dist2 = sqrt(pow(cluster.mid_x, 2) + pow(cluster.mid_y, 2));
            if (abs(dist) < 0.6)
            {
                measure_list.push_back(cluster);
                islost = false;
                lost_cnt = 0;
            }
            else
            {
                current.objects.push_back(cluster);
            }
            if (dist2 < 0.2)
            {
                state = STOP;
            }
        }

        if (!islost)
        {
            lost_cnt = 0;
            int m_idx = 0;
            if (measure_list.size() > 1)
            {
                std::vector<double> error;
                for (auto measure : measure_list)
                {
                    ros::Duration duration_t = measure.Header.stamp - pre_time;
                    const double dt = duration_t.toSec();
                    error.push_back(evaluateMeasurement(e, measure.mid_x, measure.mid_y, dt));
                }
                double tmp_err = 100.0;
                m_idx = 0;
                for (size_t idx = 0; idx < error.size(); idx++) // find minimum error
                {
                    if (tmp_err > error.at(idx))
                    {
                        tmp_err = error.at(idx);
                        m_idx = idx;
                    }
                }
            }
            for (std::size_t i = 0; i < measure_list.size(); i++)
            {
                if (i != m_idx)
                    current.objects.push_back(measure_list[i]);
            }
            ros::Time now_time = measure_list[m_idx].Header.stamp;
            ros::Duration duration_t = now_time - pre_time;
            const double dt = duration_t.toSec();

            updateMeasurement(m, measure_list[m_idx].mid_x, measure_list[m_idx].mid_y, dt);

            /* Kalman Filter Processing */
            Eigen::VectorXd z(2);
            z << m.now_pos[X], m.now_pos[Y];
            kf.updateTime(dt);
            kf.processKalmanFilter(z);
            updateEstimation(e, kf.getPosX(), kf.getPosY(), kf.getVelX(), kf.getVelY());
            current.Header.stamp = now_time;
            current.x = e.pos[X];
            current.y = e.pos[Y];
            current.vx = e.vel[X];
            current.vy = e.vel[Y];
            publishPlot(x_comp_pub, y_comp_pub,
                        m.now_pos[X], m.now_pos[Y], e.pos[X], e.pos[Y],
                        m.now_vel[X], m.now_vel[Y], e.vel[X], e.vel[Y]);
            publishEstimationBox(estimate_pub, e.pos[X], e.pos[Y], state);
            pre_time = now_time;
        }
        else
        {
            lost_cnt++;
        }
        current.lost_cnt = lost_cnt;
        if (lost_cnt > 10)
        {
            state = LOST;
        }
        break;
    }
    }
    current_pub.publish(current);
    status_pub.publish(status);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "tracking_node");
    ROS_INFO("\033----> Tracking Started.\033");
    ros::NodeHandle nh;
    std::string node_str = "/track";
    std::string topicx_str[4] = {"/measurement_x", "/estimation_x", "/measurement_vx", "/estimation_vx"};
    std::string topicy_str[4] = {"/measurement_y", "/estimation_y", "/measurement_vy", "/estimation_vy"};

    ros::Subscriber clusterlist_sub = nh.subscribe<cartbot::ClusterArray>("/cluster/clusterarray", 1, clusterlistCallback);
    estimate_pub = nh.advertise<jsk_recognition_msgs::BoundingBox>(node_str + "/estimation_box", 1);
    current_pub = nh.advertise<cartbot::Current>(node_str + "/current", 1);
    status_pub = nh.advertise<std_msgs::String>("status/message", 1);

    for (std::size_t i = 0; i < 4; i++)
    {
        x_comp_pub[i] = nh.advertise<std_msgs::Float64>(node_str + topicx_str[i], 1);
        y_comp_pub[i] = nh.advertise<std_msgs::Float64>(node_str + topicy_str[i], 1);
    }
    if (!getParameter(nh))
    {
        ROS_ERROR_STREAM("Check tracking node parameter!");
        exit(0);
    }
    ros::MultiThreadedSpinner spinner(4);
    spinner.spin();
    return 0;
}