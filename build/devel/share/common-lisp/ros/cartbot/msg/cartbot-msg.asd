
(cl:in-package :asdf)

(defsystem "cartbot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Cluster" :depends-on ("_package_Cluster"))
    (:file "_package_Cluster" :depends-on ("_package"))
    (:file "Cluster" :depends-on ("_package_Cluster"))
    (:file "_package_Cluster" :depends-on ("_package"))
    (:file "ClusterArray" :depends-on ("_package_ClusterArray"))
    (:file "_package_ClusterArray" :depends-on ("_package"))
    (:file "ClusterArray" :depends-on ("_package_ClusterArray"))
    (:file "_package_ClusterArray" :depends-on ("_package"))
    (:file "Current" :depends-on ("_package_Current"))
    (:file "_package_Current" :depends-on ("_package"))
    (:file "Current" :depends-on ("_package_Current"))
    (:file "_package_Current" :depends-on ("_package"))
    (:file "Encoder" :depends-on ("_package_Encoder"))
    (:file "_package_Encoder" :depends-on ("_package"))
    (:file "Encoder" :depends-on ("_package_Encoder"))
    (:file "_package_Encoder" :depends-on ("_package"))
    (:file "Speed" :depends-on ("_package_Speed"))
    (:file "_package_Speed" :depends-on ("_package"))
    (:file "Speed" :depends-on ("_package_Speed"))
    (:file "_package_Speed" :depends-on ("_package"))
  ))