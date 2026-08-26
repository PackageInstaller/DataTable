-- chunkname: @modules/proto/Activity199Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity199Module_pb", package.seeall)

local Activity199Module_pb = {}

Activity199Module_pb.GET199INFOREQUEST_MSG = protobuf.Descriptor()
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.ACT199GAINREQUEST_MSG = protobuf.Descriptor()
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.ACT199GAINREPLY_MSG = protobuf.Descriptor()
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.GET199INFOREPLY_MSG = protobuf.Descriptor()
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD = protobuf.FieldDescriptor()
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.full_name = ".Get199InfoRequest.activityId"
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.number = 1
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.index = 0
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.label = 1
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.type = 5
Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity199Module_pb.GET199INFOREQUEST_MSG.name = "Get199InfoRequest"
Activity199Module_pb.GET199INFOREQUEST_MSG.full_name = ".Get199InfoRequest"
Activity199Module_pb.GET199INFOREQUEST_MSG.nested_types = {}
Activity199Module_pb.GET199INFOREQUEST_MSG.enum_types = {}
Activity199Module_pb.GET199INFOREQUEST_MSG.fields = {
	Activity199Module_pb.GET199INFOREQUESTACTIVITYIDFIELD
}
Activity199Module_pb.GET199INFOREQUEST_MSG.is_extendable = false
Activity199Module_pb.GET199INFOREQUEST_MSG.extensions = {}
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.name = "activityId"
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.full_name = ".Act199GainRequest.activityId"
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.number = 1
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.index = 0
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.label = 1
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.has_default_value = false
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.default_value = 0
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.type = 5
Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.name = "heroId"
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.full_name = ".Act199GainRequest.heroId"
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.number = 2
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.index = 1
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.label = 1
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.has_default_value = false
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.default_value = 0
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.type = 5
Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD.cpp_type = 1
Activity199Module_pb.ACT199GAINREQUEST_MSG.name = "Act199GainRequest"
Activity199Module_pb.ACT199GAINREQUEST_MSG.full_name = ".Act199GainRequest"
Activity199Module_pb.ACT199GAINREQUEST_MSG.nested_types = {}
Activity199Module_pb.ACT199GAINREQUEST_MSG.enum_types = {}
Activity199Module_pb.ACT199GAINREQUEST_MSG.fields = {
	Activity199Module_pb.ACT199GAINREQUESTACTIVITYIDFIELD,
	Activity199Module_pb.ACT199GAINREQUESTHEROIDFIELD
}
Activity199Module_pb.ACT199GAINREQUEST_MSG.is_extendable = false
Activity199Module_pb.ACT199GAINREQUEST_MSG.extensions = {}
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.name = "activityId"
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.full_name = ".Act199GainReply.activityId"
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.number = 1
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.index = 0
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.label = 1
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.has_default_value = false
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.default_value = 0
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.type = 5
Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD.cpp_type = 1
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.name = "heroId"
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.full_name = ".Act199GainReply.heroId"
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.number = 2
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.index = 1
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.label = 1
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.has_default_value = false
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.default_value = 0
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.type = 5
Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD.cpp_type = 1
Activity199Module_pb.ACT199GAINREPLY_MSG.name = "Act199GainReply"
Activity199Module_pb.ACT199GAINREPLY_MSG.full_name = ".Act199GainReply"
Activity199Module_pb.ACT199GAINREPLY_MSG.nested_types = {}
Activity199Module_pb.ACT199GAINREPLY_MSG.enum_types = {}
Activity199Module_pb.ACT199GAINREPLY_MSG.fields = {
	Activity199Module_pb.ACT199GAINREPLYACTIVITYIDFIELD,
	Activity199Module_pb.ACT199GAINREPLYHEROIDFIELD
}
Activity199Module_pb.ACT199GAINREPLY_MSG.is_extendable = false
Activity199Module_pb.ACT199GAINREPLY_MSG.extensions = {}
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.full_name = ".Get199InfoReply.activityId"
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.number = 1
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.index = 0
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.label = 1
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.type = 5
Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.name = "heroId"
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.full_name = ".Get199InfoReply.heroId"
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.number = 2
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.index = 1
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.label = 1
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.has_default_value = false
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.default_value = 0
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.type = 5
Activity199Module_pb.GET199INFOREPLYHEROIDFIELD.cpp_type = 1
Activity199Module_pb.GET199INFOREPLY_MSG.name = "Get199InfoReply"
Activity199Module_pb.GET199INFOREPLY_MSG.full_name = ".Get199InfoReply"
Activity199Module_pb.GET199INFOREPLY_MSG.nested_types = {}
Activity199Module_pb.GET199INFOREPLY_MSG.enum_types = {}
Activity199Module_pb.GET199INFOREPLY_MSG.fields = {
	Activity199Module_pb.GET199INFOREPLYACTIVITYIDFIELD,
	Activity199Module_pb.GET199INFOREPLYHEROIDFIELD
}
Activity199Module_pb.GET199INFOREPLY_MSG.is_extendable = false
Activity199Module_pb.GET199INFOREPLY_MSG.extensions = {}
Activity199Module_pb.Act199GainReply = protobuf.Message(Activity199Module_pb.ACT199GAINREPLY_MSG)
Activity199Module_pb.Act199GainRequest = protobuf.Message(Activity199Module_pb.ACT199GAINREQUEST_MSG)
Activity199Module_pb.Get199InfoReply = protobuf.Message(Activity199Module_pb.GET199INFOREPLY_MSG)
Activity199Module_pb.Get199InfoRequest = protobuf.Message(Activity199Module_pb.GET199INFOREQUEST_MSG)

return Activity199Module_pb
