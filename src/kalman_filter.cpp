#include <iostream>
#include <vector>
#include <cartbot/kalman_filter.h>

void KalmanFilter::initMatrix(const Eigen::MatrixXd &A_,
                        const Eigen::MatrixXd &H_,
                        const Eigen::MatrixXd &R_,
                        const Eigen::MatrixXd &P_,
                        const Eigen::MatrixXd &Q_)
{
    A = A_;
    H = H_;
    R = R_;
    P0 = P_;
    Q = Q_;
    m = H.rows();
    n = A.rows();
    x_hat.setZero();
    x_hat.resize(n);
    I.resize(n, n);
    I.setIdentity();
    initialized = true;
}

void KalmanFilter::updateTime(const double &dt)
{
    if (!initialized)
    {
        std::cout << "Filter is not initialized" << std::endl;
    }
    Eigen::Matrix2d tmp_A;
    tmp_A << dt, 0,
             0, dt;
    A.block<2, 2>(0,2) = tmp_A;
}

void KalmanFilter::initValue(const Eigen::VectorXd& x0)
{
    x_hat = x0;
    P = P0;
    initialized = true;
}

void KalmanFilter::processKalmanFilter(const Eigen::VectorXd &z) // Sensor input matrix
{
    if (!initialized)
    {
        std::cout << "Filter is not initialized" << std::endl;
    }

    /* Prediction */
    x_hat = A * x_hat;             // State Space Equation
    P = A * P * A.transpose() + Q; // Calculate Covariance Matrix

    /* Measurement */
    K = P * H.transpose() * (H * P * H.transpose() + R).inverse();
    x_hat += K * (z - H * x_hat);
    P = (I - K * H) * P;
}