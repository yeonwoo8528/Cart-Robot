// Auto-generated. Do not edit!

// (in-package cartbot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Encoder {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.enc_cnt_l = null;
      this.enc_cnt_r = null;
    }
    else {
      if (initObj.hasOwnProperty('enc_cnt_l')) {
        this.enc_cnt_l = initObj.enc_cnt_l
      }
      else {
        this.enc_cnt_l = 0;
      }
      if (initObj.hasOwnProperty('enc_cnt_r')) {
        this.enc_cnt_r = initObj.enc_cnt_r
      }
      else {
        this.enc_cnt_r = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Encoder
    // Serialize message field [enc_cnt_l]
    bufferOffset = _serializer.uint16(obj.enc_cnt_l, buffer, bufferOffset);
    // Serialize message field [enc_cnt_r]
    bufferOffset = _serializer.uint16(obj.enc_cnt_r, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Encoder
    let len;
    let data = new Encoder(null);
    // Deserialize message field [enc_cnt_l]
    data.enc_cnt_l = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [enc_cnt_r]
    data.enc_cnt_r = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'cartbot/Encoder';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '40436c2be102fd0207dc1c1d05c2ef2c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint16 enc_cnt_l
    uint16 enc_cnt_r
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Encoder(null);
    if (msg.enc_cnt_l !== undefined) {
      resolved.enc_cnt_l = msg.enc_cnt_l;
    }
    else {
      resolved.enc_cnt_l = 0
    }

    if (msg.enc_cnt_r !== undefined) {
      resolved.enc_cnt_r = msg.enc_cnt_r;
    }
    else {
      resolved.enc_cnt_r = 0
    }

    return resolved;
    }
};

module.exports = Encoder;
