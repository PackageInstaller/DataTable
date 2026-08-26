-- chunkname: @modules/proto/Activity134Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity134Module_pb", package.seeall)

local Activity134Module_pb = {}

Activity134Module_pb.TASKMODULE_PB = require("modules.proto.TaskModule_pb")
Activity134Module_pb.ACT134BONUSREQUEST_MSG = protobuf.Descriptor()
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.ACT134BONUSREPLY_MSG = protobuf.Descriptor()
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.ACT134BONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.GET134INFOSREQUEST_MSG = protobuf.Descriptor()
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.GET134INFOSREPLY_MSG = protobuf.Descriptor()
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD = protobuf.FieldDescriptor()
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act134BonusRequest.activityId"
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.name = "id"
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.full_name = ".Act134BonusRequest.id"
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.number = 2
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.index = 1
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.label = 1
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.has_default_value = false
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.default_value = 0
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.type = 5
Activity134Module_pb.ACT134BONUSREQUESTIDFIELD.cpp_type = 1
Activity134Module_pb.ACT134BONUSREQUEST_MSG.name = "Act134BonusRequest"
Activity134Module_pb.ACT134BONUSREQUEST_MSG.full_name = ".Act134BonusRequest"
Activity134Module_pb.ACT134BONUSREQUEST_MSG.nested_types = {}
Activity134Module_pb.ACT134BONUSREQUEST_MSG.enum_types = {}
Activity134Module_pb.ACT134BONUSREQUEST_MSG.fields = {
	Activity134Module_pb.ACT134BONUSREQUESTACTIVITYIDFIELD,
	Activity134Module_pb.ACT134BONUSREQUESTIDFIELD
}
Activity134Module_pb.ACT134BONUSREQUEST_MSG.is_extendable = false
Activity134Module_pb.ACT134BONUSREQUEST_MSG.extensions = {}
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.full_name = ".Act134BonusReply.activityId"
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.number = 1
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.index = 0
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.label = 1
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.type = 5
Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.name = "id"
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.full_name = ".Act134BonusReply.id"
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.number = 2
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.index = 1
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.label = 1
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.has_default_value = false
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.default_value = 0
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.type = 5
Activity134Module_pb.ACT134BONUSREPLYIDFIELD.cpp_type = 1
Activity134Module_pb.ACT134BONUSREPLY_MSG.name = "Act134BonusReply"
Activity134Module_pb.ACT134BONUSREPLY_MSG.full_name = ".Act134BonusReply"
Activity134Module_pb.ACT134BONUSREPLY_MSG.nested_types = {}
Activity134Module_pb.ACT134BONUSREPLY_MSG.enum_types = {}
Activity134Module_pb.ACT134BONUSREPLY_MSG.fields = {
	Activity134Module_pb.ACT134BONUSREPLYACTIVITYIDFIELD,
	Activity134Module_pb.ACT134BONUSREPLYIDFIELD
}
Activity134Module_pb.ACT134BONUSREPLY_MSG.is_extendable = false
Activity134Module_pb.ACT134BONUSREPLY_MSG.extensions = {}
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get134InfosRequest.activityId"
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity134Module_pb.GET134INFOSREQUEST_MSG.name = "Get134InfosRequest"
Activity134Module_pb.GET134INFOSREQUEST_MSG.full_name = ".Get134InfosRequest"
Activity134Module_pb.GET134INFOSREQUEST_MSG.nested_types = {}
Activity134Module_pb.GET134INFOSREQUEST_MSG.enum_types = {}
Activity134Module_pb.GET134INFOSREQUEST_MSG.fields = {
	Activity134Module_pb.GET134INFOSREQUESTACTIVITYIDFIELD
}
Activity134Module_pb.GET134INFOSREQUEST_MSG.is_extendable = false
Activity134Module_pb.GET134INFOSREQUEST_MSG.extensions = {}
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.full_name = ".Get134InfosReply.activityId"
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.number = 1
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.index = 0
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.label = 1
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.type = 5
Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.full_name = ".Get134InfosReply.hasGetBonusIds"
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.number = 2
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.index = 1
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.label = 3
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.has_default_value = false
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.default_value = {}
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.type = 5
Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD.cpp_type = 1
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.name = "tasks"
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.full_name = ".Get134InfosReply.tasks"
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.number = 3
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.index = 2
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.label = 3
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.has_default_value = false
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.default_value = {}
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.message_type = Activity134Module_pb.TASKMODULE_PB.TASK_MSG
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.type = 11
Activity134Module_pb.GET134INFOSREPLYTASKSFIELD.cpp_type = 10
Activity134Module_pb.GET134INFOSREPLY_MSG.name = "Get134InfosReply"
Activity134Module_pb.GET134INFOSREPLY_MSG.full_name = ".Get134InfosReply"
Activity134Module_pb.GET134INFOSREPLY_MSG.nested_types = {}
Activity134Module_pb.GET134INFOSREPLY_MSG.enum_types = {}
Activity134Module_pb.GET134INFOSREPLY_MSG.fields = {
	Activity134Module_pb.GET134INFOSREPLYACTIVITYIDFIELD,
	Activity134Module_pb.GET134INFOSREPLYHASGETBONUSIDSFIELD,
	Activity134Module_pb.GET134INFOSREPLYTASKSFIELD
}
Activity134Module_pb.GET134INFOSREPLY_MSG.is_extendable = false
Activity134Module_pb.GET134INFOSREPLY_MSG.extensions = {}
Activity134Module_pb.Act134BonusReply = protobuf.Message(Activity134Module_pb.ACT134BONUSREPLY_MSG)
Activity134Module_pb.Act134BonusRequest = protobuf.Message(Activity134Module_pb.ACT134BONUSREQUEST_MSG)
Activity134Module_pb.Get134InfosReply = protobuf.Message(Activity134Module_pb.GET134INFOSREPLY_MSG)
Activity134Module_pb.Get134InfosRequest = protobuf.Message(Activity134Module_pb.GET134INFOSREQUEST_MSG)

return Activity134Module_pb
