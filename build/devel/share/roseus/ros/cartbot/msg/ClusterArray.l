;; Auto-generated. Do not edit!


(when (boundp 'cartbot::ClusterArray)
  (if (not (find-package "CARTBOT"))
    (make-package "CARTBOT"))
  (shadow 'ClusterArray (find-package "CARTBOT")))
(unless (find-package "CARTBOT::CLUSTERARRAY")
  (make-package "CARTBOT::CLUSTERARRAY"))

(in-package "ROS")
;;//! \htmlinclude ClusterArray.msg.html


(defclass cartbot::ClusterArray
  :super ros::object
  :slots (_Clusters ))

(defmethod cartbot::ClusterArray
  (:init
   (&key
    ((:Clusters __Clusters) ())
    )
   (send-super :init)
   (setq _Clusters __Clusters)
   self)
  (:Clusters
   (&rest __Clusters)
   (if (keywordp (car __Clusters))
       (send* _Clusters __Clusters)
     (progn
       (if __Clusters (setq _Clusters (car __Clusters)))
       _Clusters)))
  (:serialization-length
   ()
   (+
    ;; cartbot/Cluster[] _Clusters
    (apply #'+ (send-all _Clusters :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; cartbot/Cluster[] _Clusters
     (write-long (length _Clusters) s)
     (dolist (elem _Clusters)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; cartbot/Cluster[] _Clusters
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _Clusters (let (r) (dotimes (i n) (push (instance cartbot::Cluster :init) r)) r))
     (dolist (elem- _Clusters)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get cartbot::ClusterArray :md5sum-) "087be88d97f8feab35832e96802395f5")
(setf (get cartbot::ClusterArray :datatype-) "cartbot/ClusterArray")
(setf (get cartbot::ClusterArray :definition-)
      "cartbot/Cluster[] Clusters
================================================================================
MSG: cartbot/Cluster
Header Header
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



(provide :cartbot/ClusterArray "087be88d97f8feab35832e96802395f5")


