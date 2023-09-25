;; Auto-generated. Do not edit!


(when (boundp 'cartbot::Current)
  (if (not (find-package "CARTBOT"))
    (make-package "CARTBOT"))
  (shadow 'Current (find-package "CARTBOT")))
(unless (find-package "CARTBOT::CURRENT")
  (make-package "CARTBOT::CURRENT"))

(in-package "ROS")
;;//! \htmlinclude Current.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*STOP*" (find-package "CARTBOT::CURRENT"))
(shadow '*STOP* (find-package "CARTBOT::CURRENT"))
(defconstant cartbot::Current::*STOP* 0)
(intern "*LOST*" (find-package "CARTBOT::CURRENT"))
(shadow '*LOST* (find-package "CARTBOT::CURRENT"))
(defconstant cartbot::Current::*LOST* 1)
(intern "*COUNT*" (find-package "CARTBOT::CURRENT"))
(shadow '*COUNT* (find-package "CARTBOT::CURRENT"))
(defconstant cartbot::Current::*COUNT* 2)
(intern "*INIT*" (find-package "CARTBOT::CURRENT"))
(shadow '*INIT* (find-package "CARTBOT::CURRENT"))
(defconstant cartbot::Current::*INIT* 3)
(intern "*TRACKING*" (find-package "CARTBOT::CURRENT"))
(shadow '*TRACKING* (find-package "CARTBOT::CURRENT"))
(defconstant cartbot::Current::*TRACKING* 4)

(defun cartbot::Current-to-symbol (const)
  (cond
        ((= const 0) 'cartbot::Current::*STOP*)
        ((= const 1) 'cartbot::Current::*LOST*)
        ((= const 2) 'cartbot::Current::*COUNT*)
        ((= const 3) 'cartbot::Current::*INIT*)
        ((= const 4) 'cartbot::Current::*TRACKING*)
        (t nil)))

(defclass cartbot::Current
  :super ros::object
  :slots (_Header _x _y _vx _vy _objects _state _lost_cnt ))

(defmethod cartbot::Current
  (:init
   (&key
    ((:Header __Header) (instance std_msgs::Header :init))
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:vx __vx) 0.0)
    ((:vy __vy) 0.0)
    ((:objects __objects) ())
    ((:state __state) 0)
    ((:lost_cnt __lost_cnt) 0)
    )
   (send-super :init)
   (setq _Header __Header)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _vx (float __vx))
   (setq _vy (float __vy))
   (setq _objects __objects)
   (setq _state (round __state))
   (setq _lost_cnt (round __lost_cnt))
   self)
  (:Header
   (&rest __Header)
   (if (keywordp (car __Header))
       (send* _Header __Header)
     (progn
       (if __Header (setq _Header (car __Header)))
       _Header)))
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:vx
   (&optional __vx)
   (if __vx (setq _vx __vx)) _vx)
  (:vy
   (&optional __vy)
   (if __vy (setq _vy __vy)) _vy)
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:lost_cnt
   (&optional __lost_cnt)
   (if __lost_cnt (setq _lost_cnt __lost_cnt)) _lost_cnt)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _Header
    (send _Header :serialization-length)
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _vx
    8
    ;; float64 _vy
    8
    ;; cartbot/Cluster[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ;; uint8 _state
    1
    ;; int32 _lost_cnt
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _Header
       (send _Header :serialize s)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vx
       (sys::poke _vx (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vy
       (sys::poke _vy (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; cartbot/Cluster[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;; uint8 _state
       (write-byte _state s)
     ;; int32 _lost_cnt
       (write-long _lost_cnt s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _Header
     (send _Header :deserialize buf ptr-) (incf ptr- (send _Header :serialization-length))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vx
     (setq _vx (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vy
     (setq _vy (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; cartbot/Cluster[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance cartbot::Cluster :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8 _state
     (setq _state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int32 _lost_cnt
     (setq _lost_cnt (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get cartbot::Current :md5sum-) "4d01d6a47dea24abe185d87c51f91fc5")
(setf (get cartbot::Current :datatype-) "cartbot/Current")
(setf (get cartbot::Current :definition-)
      "Header Header
float64 x
float64 y
float64 vx
float64 vy
cartbot/Cluster[] objects
uint8 state
int32 lost_cnt
uint8 STOP=0
uint8 LOST=1
uint8 COUNT=2
uint8 INIT=3
uint8 TRACKING=4
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: cartbot/Cluster
Header Header
int32 id
float64 mid_x
float64 mid_y
float64 dist
geometry_msgs/Point[] points
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :cartbot/Current "4d01d6a47dea24abe185d87c51f91fc5")


