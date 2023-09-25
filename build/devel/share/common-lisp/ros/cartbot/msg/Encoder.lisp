; Auto-generated. Do not edit!


(cl:in-package cartbot-msg)


;//! \htmlinclude Encoder.msg.html

(cl:defclass <Encoder> (roslisp-msg-protocol:ros-message)
  ((enc_cnt_l
    :reader enc_cnt_l
    :initarg :enc_cnt_l
    :type cl:fixnum
    :initform 0)
   (enc_cnt_r
    :reader enc_cnt_r
    :initarg :enc_cnt_r
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Encoder (<Encoder>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Encoder>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Encoder)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name cartbot-msg:<Encoder> is deprecated: use cartbot-msg:Encoder instead.")))

(cl:ensure-generic-function 'enc_cnt_l-val :lambda-list '(m))
(cl:defmethod enc_cnt_l-val ((m <Encoder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cartbot-msg:enc_cnt_l-val is deprecated.  Use cartbot-msg:enc_cnt_l instead.")
  (enc_cnt_l m))

(cl:ensure-generic-function 'enc_cnt_r-val :lambda-list '(m))
(cl:defmethod enc_cnt_r-val ((m <Encoder>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader cartbot-msg:enc_cnt_r-val is deprecated.  Use cartbot-msg:enc_cnt_r instead.")
  (enc_cnt_r m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Encoder>) ostream)
  "Serializes a message object of type '<Encoder>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'enc_cnt_l)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'enc_cnt_l)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'enc_cnt_r)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'enc_cnt_r)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Encoder>) istream)
  "Deserializes a message object of type '<Encoder>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'enc_cnt_l)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'enc_cnt_l)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'enc_cnt_r)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'enc_cnt_r)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Encoder>)))
  "Returns string type for a message object of type '<Encoder>"
  "cartbot/Encoder")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Encoder)))
  "Returns string type for a message object of type 'Encoder"
  "cartbot/Encoder")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Encoder>)))
  "Returns md5sum for a message object of type '<Encoder>"
  "40436c2be102fd0207dc1c1d05c2ef2c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Encoder)))
  "Returns md5sum for a message object of type 'Encoder"
  "40436c2be102fd0207dc1c1d05c2ef2c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Encoder>)))
  "Returns full string definition for message of type '<Encoder>"
  (cl:format cl:nil "uint16 enc_cnt_l~%uint16 enc_cnt_r~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Encoder)))
  "Returns full string definition for message of type 'Encoder"
  (cl:format cl:nil "uint16 enc_cnt_l~%uint16 enc_cnt_r~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Encoder>))
  (cl:+ 0
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Encoder>))
  "Converts a ROS message object to a list"
  (cl:list 'Encoder
    (cl:cons ':enc_cnt_l (enc_cnt_l msg))
    (cl:cons ':enc_cnt_r (enc_cnt_r msg))
))
