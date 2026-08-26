-- chunkname: @modules/proto/Activity133Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity133Module_pb", package.seeall)

local Activity133Module_pb = {}

Activity133Module_pb.TASKMODULE_PB = require("modules.proto.TaskModule_pb")
Activity133Module_pb.GET133INFOSREPLY_MSG = protobuf.Descriptor()
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.ACT133BONUSREQUEST_MSG = protobuf.Descriptor()
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.ACT133BONUSREPLY_MSG = protobuf.Descriptor()
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.ACT133BONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.GET133INFOSREQUEST_MSG = protobuf.Descriptor()
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.full_name = ".Get133InfosReply.activityId"
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.number = 1
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.index = 0
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.label = 1
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.type = 5
Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.full_name = ".Get133InfosReply.hasGetBonusIds"
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.number = 2
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.index = 1
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.label = 3
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.has_default_value = false
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.default_value = {}
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.type = 5
Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD.cpp_type = 1
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.name = "tasks"
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.full_name = ".Get133InfosReply.tasks"
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.number = 3
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.index = 2
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.label = 3
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.has_default_value = false
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.default_value = {}
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.message_type = Activity133Module_pb.TASKMODULE_PB.TASK_MSG
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.type = 11
Activity133Module_pb.GET133INFOSREPLYTASKSFIELD.cpp_type = 10
Activity133Module_pb.GET133INFOSREPLY_MSG.name = "Get133InfosReply"
Activity133Module_pb.GET133INFOSREPLY_MSG.full_name = ".Get133InfosReply"
Activity133Module_pb.GET133INFOSREPLY_MSG.nested_types = {}
Activity133Module_pb.GET133INFOSREPLY_MSG.enum_types = {}
Activity133Module_pb.GET133INFOSREPLY_MSG.fields = {
	Activity133Module_pb.GET133INFOSREPLYACTIVITYIDFIELD,
	Activity133Module_pb.GET133INFOSREPLYHASGETBONUSIDSFIELD,
	Activity133Module_pb.GET133INFOSREPLYTASKSFIELD
}
Activity133Module_pb.GET133INFOSREPLY_MSG.is_extendable = false
Activity133Module_pb.GET133INFOSREPLY_MSG.extensions = {}
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act133BonusRequest.activityId"
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.name = "id"
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.full_name = ".Act133BonusRequest.id"
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.number = 2
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.index = 1
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.label = 1
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.has_default_value = false
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.default_value = 0
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.type = 5
Activity133Module_pb.ACT133BONUSREQUESTIDFIELD.cpp_type = 1
Activity133Module_pb.ACT133BONUSREQUEST_MSG.name = "Act133BonusRequest"
Activity133Module_pb.ACT133BONUSREQUEST_MSG.full_name = ".Act133BonusRequest"
Activity133Module_pb.ACT133BONUSREQUEST_MSG.nested_types = {}
Activity133Module_pb.ACT133BONUSREQUEST_MSG.enum_types = {}
Activity133Module_pb.ACT133BONUSREQUEST_MSG.fields = {
	Activity133Module_pb.ACT133BONUSREQUESTACTIVITYIDFIELD,
	Activity133Module_pb.ACT133BONUSREQUESTIDFIELD
}
Activity133Module_pb.ACT133BONUSREQUEST_MSG.is_extendable = false
Activity133Module_pb.ACT133BONUSREQUEST_MSG.extensions = {}
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.full_name = ".Act133BonusReply.activityId"
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.number = 1
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.index = 0
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.label = 1
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.type = 5
Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.name = "id"
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.full_name = ".Act133BonusReply.id"
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.number = 2
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.index = 1
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.label = 1
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.has_default_value = false
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.default_value = 0
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.type = 5
Activity133Module_pb.ACT133BONUSREPLYIDFIELD.cpp_type = 1
Activity133Module_pb.ACT133BONUSREPLY_MSG.name = "Act133BonusReply"
Activity133Module_pb.ACT133BONUSREPLY_MSG.full_name = ".Act133BonusReply"
Activity133Module_pb.ACT133BONUSREPLY_MSG.nested_types = {}
Activity133Module_pb.ACT133BONUSREPLY_MSG.enum_types = {}
Activity133Module_pb.ACT133BONUSREPLY_MSG.fields = {
	Activity133Module_pb.ACT133BONUSREPLYACTIVITYIDFIELD,
	Activity133Module_pb.ACT133BONUSREPLYIDFIELD
}
Activity133Module_pb.ACT133BONUSREPLY_MSG.is_extendable = false
Activity133Module_pb.ACT133BONUSREPLY_MSG.extensions = {}
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get133InfosRequest.activityId"
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity133Module_pb.GET133INFOSREQUEST_MSG.name = "Get133InfosRequest"
Activity133Module_pb.GET133INFOSREQUEST_MSG.full_name = ".Get133InfosRequest"
Activity133Module_pb.GET133INFOSREQUEST_MSG.nested_types = {}
Activity133Module_pb.GET133INFOSREQUEST_MSG.enum_types = {}
Activity133Module_pb.GET133INFOSREQUEST_MSG.fields = {
	Activity133Module_pb.GET133INFOSREQUESTACTIVITYIDFIELD
}
Activity133Module_pb.GET133INFOSREQUEST_MSG.is_extendable = false
Activity133Module_pb.GET133INFOSREQUEST_MSG.extensions = {}
Activity133Module_pb.Act133BonusReply = protobuf.Message(Activity133Module_pb.ACT133BONUSREPLY_MSG)
Activity133Module_pb.Act133BonusRequest = protobuf.Message(Activity133Module_pb.ACT133BONUSREQUEST_MSG)
Activity133Module_pb.Get133InfosReply = protobuf.Message(Activity133Module_pb.GET133INFOSREPLY_MSG)
Activity133Module_pb.Get133InfosRequest = protobuf.Message(Activity133Module_pb.GET133INFOSREQUEST_MSG)

return Activity133Module_pb
