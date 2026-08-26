-- chunkname: @modules/proto/Activity136Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity136Module_pb", package.seeall)

local Activity136Module_pb = {}

Activity136Module_pb.GET136INFOREPLY_MSG = protobuf.Descriptor()
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.GET136INFOREQUEST_MSG = protobuf.Descriptor()
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.ACT136SELECTREQUEST_MSG = protobuf.Descriptor()
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.ACT136SELECTREPLY_MSG = protobuf.Descriptor()
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD = protobuf.FieldDescriptor()
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.full_name = ".Get136InfoReply.activityId"
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.number = 1
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.index = 0
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.label = 1
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.type = 5
Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.name = "selectHeroId"
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.full_name = ".Get136InfoReply.selectHeroId"
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.number = 2
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.index = 1
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.label = 1
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.has_default_value = false
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.default_value = 0
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.type = 5
Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD.cpp_type = 1
Activity136Module_pb.GET136INFOREPLY_MSG.name = "Get136InfoReply"
Activity136Module_pb.GET136INFOREPLY_MSG.full_name = ".Get136InfoReply"
Activity136Module_pb.GET136INFOREPLY_MSG.nested_types = {}
Activity136Module_pb.GET136INFOREPLY_MSG.enum_types = {}
Activity136Module_pb.GET136INFOREPLY_MSG.fields = {
	Activity136Module_pb.GET136INFOREPLYACTIVITYIDFIELD,
	Activity136Module_pb.GET136INFOREPLYSELECTHEROIDFIELD
}
Activity136Module_pb.GET136INFOREPLY_MSG.is_extendable = false
Activity136Module_pb.GET136INFOREPLY_MSG.extensions = {}
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.full_name = ".Get136InfoRequest.activityId"
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.number = 1
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.index = 0
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.label = 1
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.type = 5
Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity136Module_pb.GET136INFOREQUEST_MSG.name = "Get136InfoRequest"
Activity136Module_pb.GET136INFOREQUEST_MSG.full_name = ".Get136InfoRequest"
Activity136Module_pb.GET136INFOREQUEST_MSG.nested_types = {}
Activity136Module_pb.GET136INFOREQUEST_MSG.enum_types = {}
Activity136Module_pb.GET136INFOREQUEST_MSG.fields = {
	Activity136Module_pb.GET136INFOREQUESTACTIVITYIDFIELD
}
Activity136Module_pb.GET136INFOREQUEST_MSG.is_extendable = false
Activity136Module_pb.GET136INFOREQUEST_MSG.extensions = {}
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.full_name = ".Act136SelectRequest.activityId"
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.number = 1
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.index = 0
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.label = 1
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.default_value = 0
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.type = 5
Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.name = "selectHeroId"
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.full_name = ".Act136SelectRequest.selectHeroId"
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.number = 2
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.index = 1
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.label = 1
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.has_default_value = false
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.default_value = 0
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.type = 5
Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD.cpp_type = 1
Activity136Module_pb.ACT136SELECTREQUEST_MSG.name = "Act136SelectRequest"
Activity136Module_pb.ACT136SELECTREQUEST_MSG.full_name = ".Act136SelectRequest"
Activity136Module_pb.ACT136SELECTREQUEST_MSG.nested_types = {}
Activity136Module_pb.ACT136SELECTREQUEST_MSG.enum_types = {}
Activity136Module_pb.ACT136SELECTREQUEST_MSG.fields = {
	Activity136Module_pb.ACT136SELECTREQUESTACTIVITYIDFIELD,
	Activity136Module_pb.ACT136SELECTREQUESTSELECTHEROIDFIELD
}
Activity136Module_pb.ACT136SELECTREQUEST_MSG.is_extendable = false
Activity136Module_pb.ACT136SELECTREQUEST_MSG.extensions = {}
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.name = "activityId"
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.full_name = ".Act136SelectReply.activityId"
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.number = 1
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.index = 0
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.label = 1
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.has_default_value = false
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.default_value = 0
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.type = 5
Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.name = "selectHeroId"
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.full_name = ".Act136SelectReply.selectHeroId"
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.number = 2
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.index = 1
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.label = 1
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.has_default_value = false
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.default_value = 0
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.type = 5
Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD.cpp_type = 1
Activity136Module_pb.ACT136SELECTREPLY_MSG.name = "Act136SelectReply"
Activity136Module_pb.ACT136SELECTREPLY_MSG.full_name = ".Act136SelectReply"
Activity136Module_pb.ACT136SELECTREPLY_MSG.nested_types = {}
Activity136Module_pb.ACT136SELECTREPLY_MSG.enum_types = {}
Activity136Module_pb.ACT136SELECTREPLY_MSG.fields = {
	Activity136Module_pb.ACT136SELECTREPLYACTIVITYIDFIELD,
	Activity136Module_pb.ACT136SELECTREPLYSELECTHEROIDFIELD
}
Activity136Module_pb.ACT136SELECTREPLY_MSG.is_extendable = false
Activity136Module_pb.ACT136SELECTREPLY_MSG.extensions = {}
Activity136Module_pb.Act136SelectReply = protobuf.Message(Activity136Module_pb.ACT136SELECTREPLY_MSG)
Activity136Module_pb.Act136SelectRequest = protobuf.Message(Activity136Module_pb.ACT136SELECTREQUEST_MSG)
Activity136Module_pb.Get136InfoReply = protobuf.Message(Activity136Module_pb.GET136INFOREPLY_MSG)
Activity136Module_pb.Get136InfoRequest = protobuf.Message(Activity136Module_pb.GET136INFOREQUEST_MSG)

return Activity136Module_pb
