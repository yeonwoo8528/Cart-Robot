; Auto-generated. Do not edit!


(cl:in-package cartbot-msg)


;//! \htmlinclude ClusterArray.msg.html

(cl:defclass <ClusterArray> (roslisp-msg-protocol:ros-message)
  ((Clusters
    :reader Clusters
    :initarg :Clusters
    :type (cl:vector cartbot-msg:Cluster)
   :initform (cl:make-array 0 :element-type 'cartbot-msg:Cluster :initial-element (cl:make-instance 'cartbot-msg:Cluster))))
)

(cl:defclass ClusterArray (<ClusterArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClusterArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClusterArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cartbot-msg:<ClusterArray> is deprecated: use cartbot-msg:ClusterArray instead.")))

(cl:ensure-generic-function 'Clusters-val :lambda-list '(m))
(cl:defmethod Clusters-val ((m <ClusterArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cartbot-msg:Clusters-val is deprecated.  Use cartbot-msg:Clusters instead.")
  (Clusters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClusterArray>) ostream)
  "Serializes a message object of type '<ClusterArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'Clusters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'Clusters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClusterArray>) istream)
  "Deserializes a message object of type '<ClusterArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'Clusters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'Clusters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'cartbot-msg:Cluster))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClusterArray>)))
  "Returns string type for a message object of type '<ClusterArray>"
  "cartbot/ClusterArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClusterArray)))
  "Returns string type for a message object of type 'ClusterArray"
  "cartbot/ClusterArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClusterArray>)))
  "Returns md5sum for a message object of type '<ClusterArray>"
  "087be88d97f8feab35832e96802395f5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClusterArray)))
  "Returns md5sum for a message object of type 'ClusterArray"
  "087be88d97f8feab35832e96802395f5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClusterArray>)))
  "Returns full string definition for message of type '<ClusterArray>"
  (cl:format cl:nil "cartbot/Cluster[] Clusters~%================================================================================~%MSG: cartbot/Cluster~%Header Header~%int32 id~%float64 mid_x~%float64 mid_y~%float64 dist~%geometry_msgs/Point[] points~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClusterArray)))
  "Returns full string definition for message of type 'ClusterArray"
  (cl:format cl:nil "cartbot/Cluster[] Clusters~%================================================================================~%MSG: cartbot/Cluster~%Header Header~%int32 id~%float64 mid_x~%float64 mid_y~%float64 dist~%geometry_msgs/Point[] points~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClusterArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'Clusters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClusterArray>))
  "Converts a ROS message object to a list"
  (cl:list 'ClusterArray
    (cl:cons ':Clusters (Clusters msg))
))
