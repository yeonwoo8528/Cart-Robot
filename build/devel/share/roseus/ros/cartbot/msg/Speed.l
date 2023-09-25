;; Auto-generated. Do not edit!


(when (boundp 'cartbot::Speed)
  (if (not (find-package "CARTBOT"))
    (make-package "CARTBOT"))
  (shadow 'Speed (find-package "CARTBOT")))
(unless (find-package "CARTBOT::SPEED")
  (make-package "CARTBOT::SPEED"))

(in-package "ROS")
;;//! \htmlinclude Speed.msg.html


(defclass cartbot::Speed
  :super ros::object
  :slots (_tar_rpm_l _tar_rpm_r ))

(defmethod cartbot::Speed
  (:init
   (&key
    ((:tar_rpm_l __tar_rpm_l) 0)
    ((:tar_rpm_r __tar_rpm_r) 0)
    )
   (send-super :init)
   (setq _tar_rpm_l (round __tar_rpm_l))
   (setq _tar_rpm_r (round __tar_rpm_r))
   self)
  (:tar_rpm_l
   (&optional __tar_rpm_l)
   (if __tar_rpm_l (setq _tar_rpm_l __tar_rpm_l)) _tar_rpm_l)
  (:tar_rpm_r
   (&optional __tar_rpm_r)
   (if __tar_rpm_r (setq _tar_rpm_r __tar_rpm_r)) _tar_rpm_r)
  (:serialization-length
   ()
   (+
    ;; int32 _tar_rpm_l
    4
    ;; int32 _tar_rpm_r
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _tar_rpm_l
       (write-long _tar_rpm_l s)
     ;; int32 _tar_rpm_r
       (write-long _tar_rpm_r s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _tar_rpm_l
     (setq _tar_rpm_l (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _tar_rpm_r
     (setq _tar_rpm_r (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get cartbot::Speed :md5sum-) "f9cfffacaa72d4427fadc8174db2c579")
(setf (get cartbot::Speed :datatype-) "cartbot/Speed")
(setf (get cartbot::Speed :definition-)
      "int32 tar_rpm_l
int32 tar_rpm_r
")



(provide :cartbot/Speed "f9cfffacaa72d4427fadc8174db2c579")


