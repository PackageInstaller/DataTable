-- chunkname: @modules/proto/Activity169Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity169Module_pb", package.seeall)

local Activity169Module_pb = {}

Activity169Module_pb.ACT169SUMMONREQUEST_MSG = protobuf.Descriptor()
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.GET169INFOREQUEST_MSG = protobuf.Descriptor()
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.GET169INFOREPLY_MSG = protobuf.Descriptor()
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.ACT169SUMMONREPLY_MSG = protobuf.Descriptor()
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD = protobuf.FieldDescriptor()
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.name = "activityId"
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.full_name = ".Act169SummonRequest.activityId"
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.number = 1
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.index = 0
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.label = 1
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.has_default_value = false
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.default_value = 0
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.type = 5
Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.name = "heroId"
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.full_name = ".Act169SummonRequest.heroId"
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.number = 2
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.index = 1
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.label = 1
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.has_default_value = false
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.default_value = 0
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.type = 5
Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD.cpp_type = 1
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.name = "Act169SummonRequest"
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.full_name = ".Act169SummonRequest"
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.nested_types = {}
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.enum_types = {}
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.fields = {
	Activity169Module_pb.ACT169SUMMONREQUESTACTIVITYIDFIELD,
	Activity169Module_pb.ACT169SUMMONREQUESTHEROIDFIELD
}
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.is_extendable = false
Activity169Module_pb.ACT169SUMMONREQUEST_MSG.extensions = {}
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.full_name = ".Get169InfoRequest.activityId"
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.number = 1
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.index = 0
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.label = 1
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.type = 5
Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity169Module_pb.GET169INFOREQUEST_MSG.name = "Get169InfoRequest"
Activity169Module_pb.GET169INFOREQUEST_MSG.full_name = ".Get169InfoRequest"
Activity169Module_pb.GET169INFOREQUEST_MSG.nested_types = {}
Activity169Module_pb.GET169INFOREQUEST_MSG.enum_types = {}
Activity169Module_pb.GET169INFOREQUEST_MSG.fields = {
	Activity169Module_pb.GET169INFOREQUESTACTIVITYIDFIELD
}
Activity169Module_pb.GET169INFOREQUEST_MSG.is_extendable = false
Activity169Module_pb.GET169INFOREQUEST_MSG.extensions = {}
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.full_name = ".Get169InfoReply.activityId"
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.number = 1
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.index = 0
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.label = 1
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.type = 5
Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.name = "heroId"
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.full_name = ".Get169InfoReply.heroId"
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.number = 2
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.index = 1
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.label = 1
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.has_default_value = false
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.default_value = 0
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.type = 5
Activity169Module_pb.GET169INFOREPLYHEROIDFIELD.cpp_type = 1
Activity169Module_pb.GET169INFOREPLY_MSG.name = "Get169InfoReply"
Activity169Module_pb.GET169INFOREPLY_MSG.full_name = ".Get169InfoReply"
Activity169Module_pb.GET169INFOREPLY_MSG.nested_types = {}
Activity169Module_pb.GET169INFOREPLY_MSG.enum_types = {}
Activity169Module_pb.GET169INFOREPLY_MSG.fields = {
	Activity169Module_pb.GET169INFOREPLYACTIVITYIDFIELD,
	Activity169Module_pb.GET169INFOREPLYHEROIDFIELD
}
Activity169Module_pb.GET169INFOREPLY_MSG.is_extendable = false
Activity169Module_pb.GET169INFOREPLY_MSG.extensions = {}
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.name = "activityId"
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.full_name = ".Act169SummonReply.activityId"
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.number = 1
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.index = 0
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.label = 1
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.has_default_value = false
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.default_value = 0
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.type = 5
Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD.cpp_type = 1
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.name = "heroId"
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.full_name = ".Act169SummonReply.heroId"
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.number = 2
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.index = 1
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.label = 1
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.has_default_value = false
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.default_value = 0
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.type = 5
Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD.cpp_type = 1
Activity169Module_pb.ACT169SUMMONREPLY_MSG.name = "Act169SummonReply"
Activity169Module_pb.ACT169SUMMONREPLY_MSG.full_name = ".Act169SummonReply"
Activity169Module_pb.ACT169SUMMONREPLY_MSG.nested_types = {}
Activity169Module_pb.ACT169SUMMONREPLY_MSG.enum_types = {}
Activity169Module_pb.ACT169SUMMONREPLY_MSG.fields = {
	Activity169Module_pb.ACT169SUMMONREPLYACTIVITYIDFIELD,
	Activity169Module_pb.ACT169SUMMONREPLYHEROIDFIELD
}
Activity169Module_pb.ACT169SUMMONREPLY_MSG.is_extendable = false
Activity169Module_pb.ACT169SUMMONREPLY_MSG.extensions = {}
Activity169Module_pb.Act169SummonReply = protobuf.Message(Activity169Module_pb.ACT169SUMMONREPLY_MSG)
Activity169Module_pb.Act169SummonRequest = protobuf.Message(Activity169Module_pb.ACT169SUMMONREQUEST_MSG)
Activity169Module_pb.Get169InfoReply = protobuf.Message(Activity169Module_pb.GET169INFOREPLY_MSG)
Activity169Module_pb.Get169InfoRequest = protobuf.Message(Activity169Module_pb.GET169INFOREQUEST_MSG)

return Activity169Module_pb
