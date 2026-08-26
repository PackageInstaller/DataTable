-- chunkname: @modules/proto/Activity196Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity196Module_pb", package.seeall)

local Activity196Module_pb = {}

Activity196Module_pb.GET196INFOREQUEST_MSG = protobuf.Descriptor()
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.ACT196GAINREPLY_MSG = protobuf.Descriptor()
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.ACT196GAINREPLYIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.GET196INFOREPLY_MSG = protobuf.Descriptor()
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.ACT196GAINREQUEST_MSG = protobuf.Descriptor()
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.ACT196GAINREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.full_name = ".Get196InfoRequest.activityId"
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.number = 1
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.index = 0
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.label = 1
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.type = 5
Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity196Module_pb.GET196INFOREQUEST_MSG.name = "Get196InfoRequest"
Activity196Module_pb.GET196INFOREQUEST_MSG.full_name = ".Get196InfoRequest"
Activity196Module_pb.GET196INFOREQUEST_MSG.nested_types = {}
Activity196Module_pb.GET196INFOREQUEST_MSG.enum_types = {}
Activity196Module_pb.GET196INFOREQUEST_MSG.fields = {
	Activity196Module_pb.GET196INFOREQUESTACTIVITYIDFIELD
}
Activity196Module_pb.GET196INFOREQUEST_MSG.is_extendable = false
Activity196Module_pb.GET196INFOREQUEST_MSG.extensions = {}
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.name = "activityId"
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.full_name = ".Act196GainReply.activityId"
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.number = 1
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.index = 0
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.label = 1
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.has_default_value = false
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.default_value = 0
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.type = 5
Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD.cpp_type = 1
Activity196Module_pb.ACT196GAINREPLYIDFIELD.name = "id"
Activity196Module_pb.ACT196GAINREPLYIDFIELD.full_name = ".Act196GainReply.id"
Activity196Module_pb.ACT196GAINREPLYIDFIELD.number = 2
Activity196Module_pb.ACT196GAINREPLYIDFIELD.index = 1
Activity196Module_pb.ACT196GAINREPLYIDFIELD.label = 1
Activity196Module_pb.ACT196GAINREPLYIDFIELD.has_default_value = false
Activity196Module_pb.ACT196GAINREPLYIDFIELD.default_value = 0
Activity196Module_pb.ACT196GAINREPLYIDFIELD.type = 5
Activity196Module_pb.ACT196GAINREPLYIDFIELD.cpp_type = 1
Activity196Module_pb.ACT196GAINREPLY_MSG.name = "Act196GainReply"
Activity196Module_pb.ACT196GAINREPLY_MSG.full_name = ".Act196GainReply"
Activity196Module_pb.ACT196GAINREPLY_MSG.nested_types = {}
Activity196Module_pb.ACT196GAINREPLY_MSG.enum_types = {}
Activity196Module_pb.ACT196GAINREPLY_MSG.fields = {
	Activity196Module_pb.ACT196GAINREPLYACTIVITYIDFIELD,
	Activity196Module_pb.ACT196GAINREPLYIDFIELD
}
Activity196Module_pb.ACT196GAINREPLY_MSG.is_extendable = false
Activity196Module_pb.ACT196GAINREPLY_MSG.extensions = {}
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.full_name = ".Get196InfoReply.activityId"
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.number = 1
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.index = 0
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.label = 1
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.type = 5
Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.name = "hasGain"
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.full_name = ".Get196InfoReply.hasGain"
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.number = 2
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.index = 1
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.label = 3
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.has_default_value = false
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.default_value = {}
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.type = 5
Activity196Module_pb.GET196INFOREPLYHASGAINFIELD.cpp_type = 1
Activity196Module_pb.GET196INFOREPLY_MSG.name = "Get196InfoReply"
Activity196Module_pb.GET196INFOREPLY_MSG.full_name = ".Get196InfoReply"
Activity196Module_pb.GET196INFOREPLY_MSG.nested_types = {}
Activity196Module_pb.GET196INFOREPLY_MSG.enum_types = {}
Activity196Module_pb.GET196INFOREPLY_MSG.fields = {
	Activity196Module_pb.GET196INFOREPLYACTIVITYIDFIELD,
	Activity196Module_pb.GET196INFOREPLYHASGAINFIELD
}
Activity196Module_pb.GET196INFOREPLY_MSG.is_extendable = false
Activity196Module_pb.GET196INFOREPLY_MSG.extensions = {}
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.name = "activityId"
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.full_name = ".Act196GainRequest.activityId"
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.number = 1
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.index = 0
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.label = 1
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.has_default_value = false
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.default_value = 0
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.type = 5
Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.name = "id"
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.full_name = ".Act196GainRequest.id"
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.number = 2
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.index = 1
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.label = 1
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.has_default_value = false
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.default_value = 0
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.type = 5
Activity196Module_pb.ACT196GAINREQUESTIDFIELD.cpp_type = 1
Activity196Module_pb.ACT196GAINREQUEST_MSG.name = "Act196GainRequest"
Activity196Module_pb.ACT196GAINREQUEST_MSG.full_name = ".Act196GainRequest"
Activity196Module_pb.ACT196GAINREQUEST_MSG.nested_types = {}
Activity196Module_pb.ACT196GAINREQUEST_MSG.enum_types = {}
Activity196Module_pb.ACT196GAINREQUEST_MSG.fields = {
	Activity196Module_pb.ACT196GAINREQUESTACTIVITYIDFIELD,
	Activity196Module_pb.ACT196GAINREQUESTIDFIELD
}
Activity196Module_pb.ACT196GAINREQUEST_MSG.is_extendable = false
Activity196Module_pb.ACT196GAINREQUEST_MSG.extensions = {}
Activity196Module_pb.Act196GainReply = protobuf.Message(Activity196Module_pb.ACT196GAINREPLY_MSG)
Activity196Module_pb.Act196GainRequest = protobuf.Message(Activity196Module_pb.ACT196GAINREQUEST_MSG)
Activity196Module_pb.Get196InfoReply = protobuf.Message(Activity196Module_pb.GET196INFOREPLY_MSG)
Activity196Module_pb.Get196InfoRequest = protobuf.Message(Activity196Module_pb.GET196INFOREQUEST_MSG)

return Activity196Module_pb
