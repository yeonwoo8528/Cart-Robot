// Auto-generated. Do not edit!

// (in-package cartbot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Cluster = require('./Cluster.js');

//-----------------------------------------------------------

class ClusterArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.Clusters = null;
    }
    else {
      if (initObj.hasOwnProperty('Clusters')) {
        this.Clusters = initObj.Clusters
      }
      else {
        this.Clusters = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ClusterArray
    // Serialize message field [Clusters]
    // Serialize the length for message field [Clusters]
    bufferOffset = _serializer.uint32(obj.Clusters.length, buffer, bufferOffset);
    obj.Clusters.forEach((val) => {
      bufferOffset = Cluster.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ClusterArray
    let len;
    let data = new ClusterArray(null);
    // Deserialize message field [Clusters]
    // Deserialize array length for message field [Clusters]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.Clusters = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.Clusters[i] = Cluster.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.Clusters.forEach((val) => {
      length += Cluster.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'cartbot/ClusterArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '087be88d97f8feab35832e96802395f5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    cartbot/Cluster[] Clusters
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ClusterArray(null);
    if (msg.Clusters !== undefined) {
      resolved.Clusters = new Array(msg.Clusters.length);
      for (let i = 0; i < resolved.Clusters.length; ++i) {
        resolved.Clusters[i] = Cluster.Resolve(msg.Clusters[i]);
      }
    }
    else {
      resolved.Clusters = []
    }

    return resolved;
    }
};

module.exports = ClusterArray;
