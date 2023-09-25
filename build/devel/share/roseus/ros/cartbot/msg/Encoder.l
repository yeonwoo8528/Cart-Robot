;; Auto-generated. Do not edit!


(when (boundp 'cartbot::Encoder)
  (if (not (find-package "CARTBOT"))
    (make-package "CARTBOT"))
  (shadow 'Encoder (find-package "CARTBOT")))
(unless (find-package "CARTBOT::ENCODER")
  (make-package "CARTBOT::ENCODER"))

(in-package "ROS")
;;//! \htmlinclude Encoder.msg.html


(defclass cartbot::Encoder
  :super ros::object
  :slots (_enc_cnt_l _enc_cnt_r ))

(defmethod cartbot::Encoder
  (:init
   (&key
    ((:enc_cnt_l __enc_cnt_l) 0)
    ((:enc_cnt_r __enc_cnt_r) 0)
    )
   (send-super :init)
   (setq _enc_cnt_l (round __enc_cnt_l))
   (setq _enc_cnt_r (round __enc_cnt_r))
   self)
  (:enc_cnt_l
   (&optional __enc_cnt_l)
   (if __enc_cnt_l (setq _enc_cnt_l __enc_cnt_l)) _enc_cnt_l)
  (:enc_cnt_r
   (&optional __enc_cnt_r)
   (if __enc_cnt_r (setq _enc_cnt_r __enc_cnt_r)) _enc_cnt_r)
  (:serialization-length
   ()
   (+
    ;; uint16 _enc_cnt_l
    2
    ;; uint16 _enc_cnt_r
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _enc_cnt_l
       (write-word _enc_cnt_l s)
     ;; uint16 _enc_cnt_r
       (write-word _enc_cnt_r s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _enc_cnt_l
     (setq _enc_cnt_l (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _enc_cnt_r
     (setq _enc_cnt_r (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get cartbot::Encoder :md5sum-) "40436c2be102fd0207dc1c1d05c2ef2c")
(setf (get cartbot::Encoder :datatype-) "cartbot/Encoder")
(setf (get cartbot::Encoder :definition-)
      "uint16 enc_cnt_l
uint16 enc_cnt_r
")



(provide :cartbot/Encoder "40436c2be102fd0207dc1c1d05c2ef2c")


