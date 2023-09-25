from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, QPushButton, QLabel, QWidget
from PyQt5.QtCore import QTimer, QTime, Qt, pyqtSlot, QThread, pyqtSignal
from PyQt5.QtGui import QFont
from std_msgs.msg import Bool, Int32, String # ROS 메시지 타입에 맞게 import 문 추가
import sys
import rospy # rospy 추가
import subprocess
import time

mode_pub = rospy.Publisher('ui/message', Bool, queue_size = 1)  # 토픽 이름과 메시지 타입에 맞게 수정
user_pub = rospy.Publisher('user/message', Bool, queue_size = 1)

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("모드 선택")
        self.setFixedSize(400, 400)

        layout = QVBoxLayout()
        layout.setAlignment(Qt.AlignCenter)

        # 타이틀 레이아웃
        titleLayout = QHBoxLayout()
        titleLayout.setAlignment(Qt.AlignCenter)

        # 타이틀 레이블 추가
        titleLabel = QLabel("SNF Cart-Robot")

        font = QFont("lato", 20)
        titleLabel.setFont(font)
        titleLayout.addWidget(titleLabel)

        layout.addLayout(titleLayout)

        # 첫 번째 버튼과 두 번째 버튼을 위로 정렬하기 위한 QHBoxLayout
        upButtonLayout = QHBoxLayout()

        mode1Button = QPushButton("Accompanying")
        mode1Button.setFixedSize(150, 80)
        mode1Button.clicked.connect(self.selectMode1)
        upButtonLayout.addWidget(mode1Button)

        mode2Button = QPushButton("Shopping")
        mode2Button.setFixedSize(150, 80)
        mode2Button.clicked.connect(self.selectMode2)
        upButtonLayout.addWidget(mode2Button)

        layout.addLayout(upButtonLayout)

        # 세 번째 버튼과 네 번째 버튼을 아래로 정렬하기 위한 QHBoxLayout
        downButtonLayout = QHBoxLayout()

        mode3Button = QPushButton("Start")
        mode3Button.setFixedSize(150, 80)
        mode3Button.clicked.connect(self.selectMode3)
        downButtonLayout.addWidget(mode3Button)

        mode4Button = QPushButton("Stop")
        mode4Button.setFixedSize(150, 80)
        mode4Button.clicked.connect(self.selectMode4)
        downButtonLayout.addWidget(mode4Button)

        layout.addLayout(downButtonLayout)

        # 시간과 배터리 잔량 표시
        timeBatteryLayout = QHBoxLayout()

        self.timeLabel = QLabel()
        timeBatteryLayout.addWidget(self.timeLabel)

        self.batteryLabel = QLabel()
        timeBatteryLayout.addWidget(self.batteryLabel)

        layout.addLayout(timeBatteryLayout)

        # 로봇의 상태 표시
        statusLayout = QHBoxLayout()
        statusLayout.setAlignment(Qt.AlignCenter)

        self.statusLabel = QLabel()
        statusLayout.addWidget(self.statusLabel)

        layout.addLayout(statusLayout)

        timer = QTimer(self)
        timer.timeout.connect(self.updateTime)
        timer.start(1000)

        self.ros_thread = ROSListenerThread(self)
        self.ros_thread.battery_updated.connect(self.updateBattery)
        self.ros_thread.status_updated.connect(self.updateStatus)
        self.ros_thread.start()

        centralWidget = QWidget()
        centralWidget.setLayout(layout)
        self.setCentralWidget(centralWidget)

        self.launch_processes = []
        self.python_processes = []

    @pyqtSlot()
    def selectMode1(self):
        print("Accompanying start")
        # ROS 메시지를 통해 값을 전달하는 코드 추가
        message = Bool()
        message.data = False  # 전달할 값 설정

        mode_pub.publish(message)

    @pyqtSlot()
    def selectMode2(self):
        print("Shopping start")
        # ROS 메시지를 통해 값을 전달하는 코드 추가
        message = Bool()
        message.data = True  # 전달할 값 설정

        mode_pub.publish(message)

    @pyqtSlot()
    def selectMode3(self):
        launch_files = ["ydlidar_ros_driver/G2.launch", "cartbot/run.launch"]
        for launch_file in launch_files:
            package_name, launch_name = launch_file.split('/')
            launch_process = subprocess.Popen(["roslaunch", package_name, launch_name], stdout=subprocess.PIPE)
            self.launch_processes.append(launch_process)
            print("Launch Process Started:", launch_file)
            time.sleep(3)

        python_files = ["rosserial_python/serial_node.py"]
        for python_file in python_files:
            package_name, python_name = python_file.split('/')
            python_process = subprocess.Popen(["rosrun", package_name, python_name], stdout=subprocess.PIPE)
            self.python_processes.append(python_process)
            print("python Process Started:", python_file)
            time.sleep(5)

        user = Bool()
        user.data = True

        user_pub.publish(user)

    @pyqtSlot()
    def selectMode4(self):
        user = Bool()
        user.data = False

        user_pub = rospy.Publisher('user/message', Bool, queue_size = 1)
        user_pub.publish(user)

        time.sleep(2)

        for launch_process in self.launch_processes:
            if launch_process.poll() is None:
                launch_process.terminate()
                print("Launch Process Terminated")
            else:
                print("No Active Launch Process")

        for python_process in self.python_processes:
            if python_process.poll() is None:
                python_process.terminate()
                print("python Process Terminated")
            else:
                print("No Active python Process")

        self.launch_processes = []
        self.python_processes = []

    def updateTime(self):
        currentTime = QTime.currentTime()
        self.timeLabel.setText("현재 시간: " + currentTime.toString("hh:mm:ss"))
    
    def updateBattery(self, battery_level):
        self.batteryLabel.setText("배터리 잔량: " + str(battery_level) + "%")

    def updateStatus(self, robot_status):
        self.statusLabel.setText("state: " + robot_status)

class ROSListenerThread(QThread):
    battery_updated = pyqtSignal(int)
    status_updated = pyqtSignal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.bat_sub = rospy.Subscriber('bat/message', Int32, self.update_battery_level)
        self.status_sub = rospy.Subscriber('status/message', String, self.update_robot_status)

    def update_battery_level(self, bat):
        battery_level = bat.data
        self.battery_updated.emit(battery_level)

    def update_robot_status(self, status):
        robot_status = status.data
        self.status_updated.emit(robot_status)

    def run(self):
        rospy.spin()

if __name__ == "__main__":
    rospy.init_node('cart_robot_gui') # rospy.init_node 추가
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())