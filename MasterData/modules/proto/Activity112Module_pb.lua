-- chunkname: @modules/proto/Activity112Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity112Module_pb", package.seeall)

local Activity112Module_pb = {}

Activity112Module_pb.EXCHANGE112REPLY_MSG = protobuf.Descriptor()
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.EXCHANGE112REPLYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.GET112INFOSREQUEST_MSG = protobuf.Descriptor()
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.EXCHANGE112REQUEST_MSG = protobuf.Descriptor()
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG = protobuf.Descriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKINFO_MSG = protobuf.Descriptor()
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.GET112INFOSREPLY_MSG = protobuf.Descriptor()
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112INFO_MSG = protobuf.Descriptor()
Activity112Module_pb.ACT112INFOIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112INFOSTATEFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG = protobuf.Descriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKPUSH_MSG = protobuf.Descriptor()
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD = protobuf.FieldDescriptor()
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.full_name = ".Exchange112Reply.activityId"
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.number = 1
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.index = 0
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.label = 1
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.type = 5
Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.name = "id"
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.full_name = ".Exchange112Reply.id"
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.number = 2
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.index = 1
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.label = 1
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.has_default_value = false
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.default_value = 0
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.type = 5
Activity112Module_pb.EXCHANGE112REPLYIDFIELD.cpp_type = 1
Activity112Module_pb.EXCHANGE112REPLY_MSG.name = "Exchange112Reply"
Activity112Module_pb.EXCHANGE112REPLY_MSG.full_name = ".Exchange112Reply"
Activity112Module_pb.EXCHANGE112REPLY_MSG.nested_types = {}
Activity112Module_pb.EXCHANGE112REPLY_MSG.enum_types = {}
Activity112Module_pb.EXCHANGE112REPLY_MSG.fields = {
	Activity112Module_pb.EXCHANGE112REPLYACTIVITYIDFIELD,
	Activity112Module_pb.EXCHANGE112REPLYIDFIELD
}
Activity112Module_pb.EXCHANGE112REPLY_MSG.is_extendable = false
Activity112Module_pb.EXCHANGE112REPLY_MSG.extensions = {}
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get112InfosRequest.activityId"
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.GET112INFOSREQUEST_MSG.name = "Get112InfosRequest"
Activity112Module_pb.GET112INFOSREQUEST_MSG.full_name = ".Get112InfosRequest"
Activity112Module_pb.GET112INFOSREQUEST_MSG.nested_types = {}
Activity112Module_pb.GET112INFOSREQUEST_MSG.enum_types = {}
Activity112Module_pb.GET112INFOSREQUEST_MSG.fields = {
	Activity112Module_pb.GET112INFOSREQUESTACTIVITYIDFIELD
}
Activity112Module_pb.GET112INFOSREQUEST_MSG.is_extendable = false
Activity112Module_pb.GET112INFOSREQUEST_MSG.extensions = {}
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.full_name = ".Exchange112Request.activityId"
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.number = 1
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.index = 0
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.label = 1
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.type = 5
Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.name = "id"
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.full_name = ".Exchange112Request.id"
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.number = 2
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.index = 1
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.label = 1
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.has_default_value = false
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.default_value = 0
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.type = 5
Activity112Module_pb.EXCHANGE112REQUESTIDFIELD.cpp_type = 1
Activity112Module_pb.EXCHANGE112REQUEST_MSG.name = "Exchange112Request"
Activity112Module_pb.EXCHANGE112REQUEST_MSG.full_name = ".Exchange112Request"
Activity112Module_pb.EXCHANGE112REQUEST_MSG.nested_types = {}
Activity112Module_pb.EXCHANGE112REQUEST_MSG.enum_types = {}
Activity112Module_pb.EXCHANGE112REQUEST_MSG.fields = {
	Activity112Module_pb.EXCHANGE112REQUESTACTIVITYIDFIELD,
	Activity112Module_pb.EXCHANGE112REQUESTIDFIELD
}
Activity112Module_pb.EXCHANGE112REQUEST_MSG.is_extendable = false
Activity112Module_pb.EXCHANGE112REQUEST_MSG.extensions = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.full_name = ".ReceiveAct112TaskRewardRequest.activityId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.number = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.index = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.label = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.type = 5
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.name = "taskId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.full_name = ".ReceiveAct112TaskRewardRequest.taskId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.number = 2
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.index = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.label = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.has_default_value = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.default_value = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.type = 5
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD.cpp_type = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.name = "ReceiveAct112TaskRewardRequest"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.full_name = ".ReceiveAct112TaskRewardRequest"
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.nested_types = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.enum_types = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.fields = {
	Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTACTIVITYIDFIELD,
	Activity112Module_pb.RECEIVEACT112TASKREWARDREQUESTTASKIDFIELD
}
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.is_extendable = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG.extensions = {}
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.name = "taskId"
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.full_name = ".Act112TaskInfo.taskId"
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.number = 1
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.index = 0
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.label = 1
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.default_value = 0
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.type = 5
Activity112Module_pb.ACT112TASKINFOTASKIDFIELD.cpp_type = 1
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.name = "progress"
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.full_name = ".Act112TaskInfo.progress"
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.number = 2
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.index = 1
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.label = 1
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.default_value = 0
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.type = 5
Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD.cpp_type = 1
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.name = "hasGetBonus"
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.full_name = ".Act112TaskInfo.hasGetBonus"
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.number = 3
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.index = 2
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.label = 1
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.default_value = false
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.type = 8
Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD.cpp_type = 7
Activity112Module_pb.ACT112TASKINFO_MSG.name = "Act112TaskInfo"
Activity112Module_pb.ACT112TASKINFO_MSG.full_name = ".Act112TaskInfo"
Activity112Module_pb.ACT112TASKINFO_MSG.nested_types = {}
Activity112Module_pb.ACT112TASKINFO_MSG.enum_types = {}
Activity112Module_pb.ACT112TASKINFO_MSG.fields = {
	Activity112Module_pb.ACT112TASKINFOTASKIDFIELD,
	Activity112Module_pb.ACT112TASKINFOPROGRESSFIELD,
	Activity112Module_pb.ACT112TASKINFOHASGETBONUSFIELD
}
Activity112Module_pb.ACT112TASKINFO_MSG.is_extendable = false
Activity112Module_pb.ACT112TASKINFO_MSG.extensions = {}
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.full_name = ".Get112InfosReply.activityId"
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.number = 1
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.index = 0
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.label = 1
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.type = 5
Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.name = "infos"
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.full_name = ".Get112InfosReply.infos"
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.number = 2
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.index = 1
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.label = 3
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.has_default_value = false
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.default_value = {}
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.message_type = Activity112Module_pb.ACT112INFO_MSG
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.type = 11
Activity112Module_pb.GET112INFOSREPLYINFOSFIELD.cpp_type = 10
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.name = "act112Tasks"
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.full_name = ".Get112InfosReply.act112Tasks"
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.number = 3
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.index = 2
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.label = 3
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.has_default_value = false
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.default_value = {}
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.message_type = Activity112Module_pb.ACT112TASKINFO_MSG
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.type = 11
Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD.cpp_type = 10
Activity112Module_pb.GET112INFOSREPLY_MSG.name = "Get112InfosReply"
Activity112Module_pb.GET112INFOSREPLY_MSG.full_name = ".Get112InfosReply"
Activity112Module_pb.GET112INFOSREPLY_MSG.nested_types = {}
Activity112Module_pb.GET112INFOSREPLY_MSG.enum_types = {}
Activity112Module_pb.GET112INFOSREPLY_MSG.fields = {
	Activity112Module_pb.GET112INFOSREPLYACTIVITYIDFIELD,
	Activity112Module_pb.GET112INFOSREPLYINFOSFIELD,
	Activity112Module_pb.GET112INFOSREPLYACT112TASKSFIELD
}
Activity112Module_pb.GET112INFOSREPLY_MSG.is_extendable = false
Activity112Module_pb.GET112INFOSREPLY_MSG.extensions = {}
Activity112Module_pb.ACT112INFOIDFIELD.name = "id"
Activity112Module_pb.ACT112INFOIDFIELD.full_name = ".Act112Info.id"
Activity112Module_pb.ACT112INFOIDFIELD.number = 1
Activity112Module_pb.ACT112INFOIDFIELD.index = 0
Activity112Module_pb.ACT112INFOIDFIELD.label = 1
Activity112Module_pb.ACT112INFOIDFIELD.has_default_value = false
Activity112Module_pb.ACT112INFOIDFIELD.default_value = 0
Activity112Module_pb.ACT112INFOIDFIELD.type = 5
Activity112Module_pb.ACT112INFOIDFIELD.cpp_type = 1
Activity112Module_pb.ACT112INFOSTATEFIELD.name = "state"
Activity112Module_pb.ACT112INFOSTATEFIELD.full_name = ".Act112Info.state"
Activity112Module_pb.ACT112INFOSTATEFIELD.number = 2
Activity112Module_pb.ACT112INFOSTATEFIELD.index = 1
Activity112Module_pb.ACT112INFOSTATEFIELD.label = 1
Activity112Module_pb.ACT112INFOSTATEFIELD.has_default_value = false
Activity112Module_pb.ACT112INFOSTATEFIELD.default_value = 0
Activity112Module_pb.ACT112INFOSTATEFIELD.type = 5
Activity112Module_pb.ACT112INFOSTATEFIELD.cpp_type = 1
Activity112Module_pb.ACT112INFO_MSG.name = "Act112Info"
Activity112Module_pb.ACT112INFO_MSG.full_name = ".Act112Info"
Activity112Module_pb.ACT112INFO_MSG.nested_types = {}
Activity112Module_pb.ACT112INFO_MSG.enum_types = {}
Activity112Module_pb.ACT112INFO_MSG.fields = {
	Activity112Module_pb.ACT112INFOIDFIELD,
	Activity112Module_pb.ACT112INFOSTATEFIELD
}
Activity112Module_pb.ACT112INFO_MSG.is_extendable = false
Activity112Module_pb.ACT112INFO_MSG.extensions = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.full_name = ".ReceiveAct112TaskRewardReply.activityId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.number = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.index = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.label = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.type = 5
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.name = "taskId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.full_name = ".ReceiveAct112TaskRewardReply.taskId"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.number = 2
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.index = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.label = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.has_default_value = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.default_value = 0
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.type = 5
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD.cpp_type = 1
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.name = "ReceiveAct112TaskRewardReply"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.full_name = ".ReceiveAct112TaskRewardReply"
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.nested_types = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.enum_types = {}
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.fields = {
	Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYACTIVITYIDFIELD,
	Activity112Module_pb.RECEIVEACT112TASKREWARDREPLYTASKIDFIELD
}
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.is_extendable = false
Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG.extensions = {}
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.name = "activityId"
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.full_name = ".Act112TaskPush.activityId"
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.number = 1
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.index = 0
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.label = 1
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.default_value = 0
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.type = 5
Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD.cpp_type = 1
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.name = "act112Tasks"
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.full_name = ".Act112TaskPush.act112Tasks"
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.number = 2
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.index = 1
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.label = 3
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.default_value = {}
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.message_type = Activity112Module_pb.ACT112TASKINFO_MSG
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.type = 11
Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD.cpp_type = 10
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.name = "deleteTasks"
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.full_name = ".Act112TaskPush.deleteTasks"
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.number = 3
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.index = 2
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.label = 3
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.has_default_value = false
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.default_value = {}
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.message_type = Activity112Module_pb.ACT112TASKINFO_MSG
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.type = 11
Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD.cpp_type = 10
Activity112Module_pb.ACT112TASKPUSH_MSG.name = "Act112TaskPush"
Activity112Module_pb.ACT112TASKPUSH_MSG.full_name = ".Act112TaskPush"
Activity112Module_pb.ACT112TASKPUSH_MSG.nested_types = {}
Activity112Module_pb.ACT112TASKPUSH_MSG.enum_types = {}
Activity112Module_pb.ACT112TASKPUSH_MSG.fields = {
	Activity112Module_pb.ACT112TASKPUSHACTIVITYIDFIELD,
	Activity112Module_pb.ACT112TASKPUSHACT112TASKSFIELD,
	Activity112Module_pb.ACT112TASKPUSHDELETETASKSFIELD
}
Activity112Module_pb.ACT112TASKPUSH_MSG.is_extendable = false
Activity112Module_pb.ACT112TASKPUSH_MSG.extensions = {}
Activity112Module_pb.Act112Info = protobuf.Message(Activity112Module_pb.ACT112INFO_MSG)
Activity112Module_pb.Act112TaskInfo = protobuf.Message(Activity112Module_pb.ACT112TASKINFO_MSG)
Activity112Module_pb.Act112TaskPush = protobuf.Message(Activity112Module_pb.ACT112TASKPUSH_MSG)
Activity112Module_pb.Exchange112Reply = protobuf.Message(Activity112Module_pb.EXCHANGE112REPLY_MSG)
Activity112Module_pb.Exchange112Request = protobuf.Message(Activity112Module_pb.EXCHANGE112REQUEST_MSG)
Activity112Module_pb.Get112InfosReply = protobuf.Message(Activity112Module_pb.GET112INFOSREPLY_MSG)
Activity112Module_pb.Get112InfosRequest = protobuf.Message(Activity112Module_pb.GET112INFOSREQUEST_MSG)
Activity112Module_pb.ReceiveAct112TaskRewardReply = protobuf.Message(Activity112Module_pb.RECEIVEACT112TASKREWARDREPLY_MSG)
Activity112Module_pb.ReceiveAct112TaskRewardRequest = protobuf.Message(Activity112Module_pb.RECEIVEACT112TASKREWARDREQUEST_MSG)

return Activity112Module_pb
