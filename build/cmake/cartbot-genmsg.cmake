# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "cartbot: 5 messages, 0 services")

set(MSG_I_FLAGS "-Icartbot:/home/yeonwoo/Desktop/Code/cartbot-main/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Icartbot:/home/yeonwoo/Desktop/Code/cartbot-main/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(cartbot_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_custom_target(_cartbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "cartbot" "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" ""
)

get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_custom_target(_cartbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "cartbot" "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" "std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_custom_target(_cartbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "cartbot" "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" "cartbot/Cluster:std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_custom_target(_cartbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "cartbot" "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" "cartbot/Cluster:std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_custom_target(_cartbot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "cartbot" "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
)
_generate_msg_cpp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
)
_generate_msg_cpp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
)
_generate_msg_cpp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
)
_generate_msg_cpp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
)

### Generating Services

### Generating Module File
_generate_module_cpp(cartbot
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(cartbot_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(cartbot_generate_messages cartbot_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_cpp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_cpp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_cpp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_cpp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_cpp _cartbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(cartbot_gencpp)
add_dependencies(cartbot_gencpp cartbot_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS cartbot_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
)
_generate_msg_eus(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
)
_generate_msg_eus(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
)
_generate_msg_eus(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
)
_generate_msg_eus(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
)

### Generating Services

### Generating Module File
_generate_module_eus(cartbot
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(cartbot_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(cartbot_generate_messages cartbot_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_eus _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_eus _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_eus _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_eus _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_eus _cartbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(cartbot_geneus)
add_dependencies(cartbot_geneus cartbot_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS cartbot_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
)
_generate_msg_lisp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
)
_generate_msg_lisp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
)
_generate_msg_lisp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
)
_generate_msg_lisp(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
)

### Generating Services

### Generating Module File
_generate_module_lisp(cartbot
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(cartbot_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(cartbot_generate_messages cartbot_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_lisp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_lisp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_lisp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_lisp _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_lisp _cartbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(cartbot_genlisp)
add_dependencies(cartbot_genlisp cartbot_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS cartbot_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
)
_generate_msg_nodejs(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
)
_generate_msg_nodejs(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
)
_generate_msg_nodejs(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
)
_generate_msg_nodejs(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
)

### Generating Services

### Generating Module File
_generate_module_nodejs(cartbot
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(cartbot_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(cartbot_generate_messages cartbot_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_nodejs _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_nodejs _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_nodejs _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_nodejs _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_nodejs _cartbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(cartbot_gennodejs)
add_dependencies(cartbot_gennodejs cartbot_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS cartbot_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
)
_generate_msg_py(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
)
_generate_msg_py(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
)
_generate_msg_py(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg"
  "${MSG_I_FLAGS}"
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
)
_generate_msg_py(cartbot
  "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
)

### Generating Services

### Generating Module File
_generate_module_py(cartbot
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(cartbot_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(cartbot_generate_messages cartbot_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Speed.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_py _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Cluster.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_py _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/ClusterArray.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_py _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Current.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_py _cartbot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/yeonwoo/Desktop/Code/cartbot-main/msg/Encoder.msg" NAME_WE)
add_dependencies(cartbot_generate_messages_py _cartbot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(cartbot_genpy)
add_dependencies(cartbot_genpy cartbot_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS cartbot_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/cartbot
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(cartbot_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(cartbot_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET cartbot_generate_messages_cpp)
  add_dependencies(cartbot_generate_messages_cpp cartbot_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/cartbot
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(cartbot_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(cartbot_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET cartbot_generate_messages_eus)
  add_dependencies(cartbot_generate_messages_eus cartbot_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/cartbot
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(cartbot_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(cartbot_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET cartbot_generate_messages_lisp)
  add_dependencies(cartbot_generate_messages_lisp cartbot_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/cartbot
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(cartbot_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(cartbot_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET cartbot_generate_messages_nodejs)
  add_dependencies(cartbot_generate_messages_nodejs cartbot_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/cartbot
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(cartbot_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(cartbot_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET cartbot_generate_messages_py)
  add_dependencies(cartbot_generate_messages_py cartbot_generate_messages_py)
endif()
