;; Auto-generated. Do not edit!


(when (boundp 'cartbot::Cluster)
  (if (not (find-package "CARTBOT"))
    (make-package "CARTBOT"))
  (shadow 'Cluster (find-package "CARTBOT")))
(unless (find-package "CARTBOT::CLUSTER")
  (make-package "CARTBOT::CLUSTER"))

(in-package "ROS")
;;//! \htmlinclude Cluster.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass cartbot::Cluster
  :super ros::object
  :slots (_Header _id _mid_x _mid_y _dist _points ))

(defmethod cartbot::Cluster
  (:init
   (&key
    ((:Header __Header) (instance std_msgs::Header :init))
    ((:id __id) 0)
    ((:mid_x __mid_x) 0.0)
    ((:mid_y __mid_y) 0.0)
    ((:dist __dist) 0.0)
    ((:points __points) ())
    )
   (send-super :init)
   (setq _Header __Header)
   (setq _id (round __id))
   (setq _mid_x (float __mid_x))
   (setq _mid_y (float __mid_y))
   (setq _dist (float __dist))
   (setq _points __points)
   self)
  (:Header
   (&rest __Header)
   (if (keywordp (car __Header))
       (send* _Header __Header)
     (progn
       (if __Header (setq _Header (car __Header)))
       _Header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:mid_x
   (&optional __mid_x)
   (if __mid_x (setq _mid_x __mid_x)) _mid_x)
  (:mid_y
   (&optional __mid_y)
   (if __mid_y (setq _mid_y __mid_y)) _mid_y)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _Header
    (send _Header :serialization-length)
    ;; int32 _id
    4
    ;; float64 _mid_x
    8
    ;; float64 _mid_y
    8
    ;; float64 _dist
    8
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _Header
       (send _Header :serialize s)
     ;; int32 _id
       (write-long _id s)
     ;; float64 _mid_x
       (sys::poke _mid_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _mid_y
       (sys::poke _mid_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _dist
       (sys::poke _dist (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _Header
     (send _Header :deserialize buf ptr-) (incf ptr- (send _Header :serialization-length))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _mid_x
     (setq _mid_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _mid_y
     (setq _mid_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _dist
     (setq _dist (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get cartbot::Cluster :md5sum-) "5483b1a607c3b90a8b87bd87fef9ba45")
(setf (get cartbot::Cluster :datatype-) "cartbot/Cluster")
(setf (get cartbot::Cluster :definition-)
      "Header Header
int32 id
float64 mid_x
float64 mid_y
float64 dist
geometry_msgs/Point[] points
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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :cartbot/Cluster "5483b1a607c3b90a8b87bd87fef9ba45")


