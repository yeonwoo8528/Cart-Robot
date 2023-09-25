// Generated by gencpp from file cartbot/ClusterArray.msg
// DO NOT EDIT!


#ifndef CARTBOT_MESSAGE_CLUSTERARRAY_H
#define CARTBOT_MESSAGE_CLUSTERARRAY_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <cartbot/Cluster.h>

namespace cartbot
{
template <class ContainerAllocator>
struct ClusterArray_
{
  typedef ClusterArray_<ContainerAllocator> Type;

  ClusterArray_()
    : Clusters()  {
    }
  ClusterArray_(const ContainerAllocator& _alloc)
    : Clusters(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector< ::cartbot::Cluster_<ContainerAllocator> , typename std::allocator_traits<ContainerAllocator>::template rebind_alloc< ::cartbot::Cluster_<ContainerAllocator> >> _Clusters_type;
  _Clusters_type Clusters;





  typedef boost::shared_ptr< ::cartbot::ClusterArray_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::cartbot::ClusterArray_<ContainerAllocator> const> ConstPtr;

}; // struct ClusterArray_

typedef ::cartbot::ClusterArray_<std::allocator<void> > ClusterArray;

typedef boost::shared_ptr< ::cartbot::ClusterArray > ClusterArrayPtr;
typedef boost::shared_ptr< ::cartbot::ClusterArray const> ClusterArrayConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::cartbot::ClusterArray_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::cartbot::ClusterArray_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::cartbot::ClusterArray_<ContainerAllocator1> & lhs, const ::cartbot::ClusterArray_<ContainerAllocator2> & rhs)
{
  return lhs.Clusters == rhs.Clusters;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::cartbot::ClusterArray_<ContainerAllocator1> & lhs, const ::cartbot::ClusterArray_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace cartbot

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::cartbot::ClusterArray_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::cartbot::ClusterArray_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::cartbot::ClusterArray_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::cartbot::ClusterArray_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::cartbot::ClusterArray_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::cartbot::ClusterArray_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::cartbot::ClusterArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "087be88d97f8feab35832e96802395f5";
  }

  static const char* value(const ::cartbot::ClusterArray_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x087be88d97f8feabULL;
  static const uint64_t static_value2 = 0x35832e96802395f5ULL;
};

template<class ContainerAllocator>
struct DataType< ::cartbot::ClusterArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "cartbot/ClusterArray";
  }

  static const char* value(const ::cartbot::ClusterArray_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::cartbot::ClusterArray_<ContainerAllocator> >
{
  static const char* value()
  {
    return "cartbot/Cluster[] Clusters\n"
"================================================================================\n"
"MSG: cartbot/Cluster\n"
"Header Header\n"
"int32 id\n"
"float64 mid_x\n"
"float64 mid_y\n"
"float64 dist\n"
"geometry_msgs/Point[] points\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
;
  }

  static const char* value(const ::cartbot::ClusterArray_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::cartbot::ClusterArray_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.Clusters);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ClusterArray_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::cartbot::ClusterArray_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::cartbot::ClusterArray_<ContainerAllocator>& v)
  {
    s << indent << "Clusters[]" << std::endl;
    for (size_t i = 0; i < v.Clusters.size(); ++i)
    {
      s << indent << "  Clusters[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::cartbot::Cluster_<ContainerAllocator> >::stream(s, indent + "    ", v.Clusters[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // CARTBOT_MESSAGE_CLUSTERARRAY_H
