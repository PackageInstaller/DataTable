-- chunkname: @modules/proto/TaskModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.TaskModule_pb", package.seeall)

local TaskModule_pb = {}

TaskModule_pb.TASK_MSG = protobuf.Descriptor()
TaskModule_pb.TASKIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKPROGRESSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKHASFINISHEDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKFINISHCOUNTFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKTYPEFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKEXPIRYTIMEFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKACTIVITYINFO_MSG = protobuf.Descriptor()
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHREADTASKREQUEST_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKINFOREQUEST_MSG = protobuf.Descriptor()
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREQUEST_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG = protobuf.Descriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREPLY_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG = protobuf.Descriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHREADTASKREPLY_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.UPDATETASKPUSH_MSG = protobuf.Descriptor()
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD = protobuf.FieldDescriptor()
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHTASKREQUEST_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHTASKREQUESTIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHTASKREPLY_MSG = protobuf.Descriptor()
TaskModule_pb.FINISHTASKREPLYIDFIELD = protobuf.FieldDescriptor()
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD = protobuf.FieldDescriptor()
TaskModule_pb.DELETETASKPUSH_MSG = protobuf.Descriptor()
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKINFOREPLY_MSG = protobuf.Descriptor()
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD = protobuf.FieldDescriptor()
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD = protobuf.FieldDescriptor()
TaskModule_pb.TASKIDFIELD.name = "id"
TaskModule_pb.TASKIDFIELD.full_name = ".Task.id"
TaskModule_pb.TASKIDFIELD.number = 1
TaskModule_pb.TASKIDFIELD.index = 0
TaskModule_pb.TASKIDFIELD.label = 2
TaskModule_pb.TASKIDFIELD.has_default_value = false
TaskModule_pb.TASKIDFIELD.default_value = 0
TaskModule_pb.TASKIDFIELD.type = 5
TaskModule_pb.TASKIDFIELD.cpp_type = 1
TaskModule_pb.TASKPROGRESSFIELD.name = "progress"
TaskModule_pb.TASKPROGRESSFIELD.full_name = ".Task.progress"
TaskModule_pb.TASKPROGRESSFIELD.number = 2
TaskModule_pb.TASKPROGRESSFIELD.index = 1
TaskModule_pb.TASKPROGRESSFIELD.label = 2
TaskModule_pb.TASKPROGRESSFIELD.has_default_value = false
TaskModule_pb.TASKPROGRESSFIELD.default_value = 0
TaskModule_pb.TASKPROGRESSFIELD.type = 5
TaskModule_pb.TASKPROGRESSFIELD.cpp_type = 1
TaskModule_pb.TASKHASFINISHEDFIELD.name = "hasFinished"
TaskModule_pb.TASKHASFINISHEDFIELD.full_name = ".Task.hasFinished"
TaskModule_pb.TASKHASFINISHEDFIELD.number = 3
TaskModule_pb.TASKHASFINISHEDFIELD.index = 2
TaskModule_pb.TASKHASFINISHEDFIELD.label = 2
TaskModule_pb.TASKHASFINISHEDFIELD.has_default_value = false
TaskModule_pb.TASKHASFINISHEDFIELD.default_value = false
TaskModule_pb.TASKHASFINISHEDFIELD.type = 8
TaskModule_pb.TASKHASFINISHEDFIELD.cpp_type = 7
TaskModule_pb.TASKFINISHCOUNTFIELD.name = "finishCount"
TaskModule_pb.TASKFINISHCOUNTFIELD.full_name = ".Task.finishCount"
TaskModule_pb.TASKFINISHCOUNTFIELD.number = 4
TaskModule_pb.TASKFINISHCOUNTFIELD.index = 3
TaskModule_pb.TASKFINISHCOUNTFIELD.label = 1
TaskModule_pb.TASKFINISHCOUNTFIELD.has_default_value = false
TaskModule_pb.TASKFINISHCOUNTFIELD.default_value = 0
TaskModule_pb.TASKFINISHCOUNTFIELD.type = 5
TaskModule_pb.TASKFINISHCOUNTFIELD.cpp_type = 1
TaskModule_pb.TASKTYPEFIELD.name = "type"
TaskModule_pb.TASKTYPEFIELD.full_name = ".Task.type"
TaskModule_pb.TASKTYPEFIELD.number = 5
TaskModule_pb.TASKTYPEFIELD.index = 4
TaskModule_pb.TASKTYPEFIELD.label = 1
TaskModule_pb.TASKTYPEFIELD.has_default_value = false
TaskModule_pb.TASKTYPEFIELD.default_value = 0
TaskModule_pb.TASKTYPEFIELD.type = 5
TaskModule_pb.TASKTYPEFIELD.cpp_type = 1
TaskModule_pb.TASKEXPIRYTIMEFIELD.name = "expiryTime"
TaskModule_pb.TASKEXPIRYTIMEFIELD.full_name = ".Task.expiryTime"
TaskModule_pb.TASKEXPIRYTIMEFIELD.number = 6
TaskModule_pb.TASKEXPIRYTIMEFIELD.index = 5
TaskModule_pb.TASKEXPIRYTIMEFIELD.label = 1
TaskModule_pb.TASKEXPIRYTIMEFIELD.has_default_value = false
TaskModule_pb.TASKEXPIRYTIMEFIELD.default_value = 0
TaskModule_pb.TASKEXPIRYTIMEFIELD.type = 5
TaskModule_pb.TASKEXPIRYTIMEFIELD.cpp_type = 1
TaskModule_pb.TASK_MSG.name = "Task"
TaskModule_pb.TASK_MSG.full_name = ".Task"
TaskModule_pb.TASK_MSG.nested_types = {}
TaskModule_pb.TASK_MSG.enum_types = {}
TaskModule_pb.TASK_MSG.fields = {
	TaskModule_pb.TASKIDFIELD,
	TaskModule_pb.TASKPROGRESSFIELD,
	TaskModule_pb.TASKHASFINISHEDFIELD,
	TaskModule_pb.TASKFINISHCOUNTFIELD,
	TaskModule_pb.TASKTYPEFIELD,
	TaskModule_pb.TASKEXPIRYTIMEFIELD
}
TaskModule_pb.TASK_MSG.is_extendable = false
TaskModule_pb.TASK_MSG.extensions = {}
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.name = "typeId"
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.full_name = ".TaskActivityInfo.typeId"
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.number = 1
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.index = 0
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.label = 2
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.has_default_value = false
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.default_value = 0
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.type = 5
TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD.cpp_type = 1
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.name = "defineId"
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.full_name = ".TaskActivityInfo.defineId"
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.number = 2
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.index = 1
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.label = 2
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.has_default_value = false
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.default_value = 0
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.type = 5
TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD.cpp_type = 1
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.name = "value"
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.full_name = ".TaskActivityInfo.value"
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.number = 3
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.index = 2
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.label = 2
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.has_default_value = false
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.default_value = 0
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.type = 5
TaskModule_pb.TASKACTIVITYINFOVALUEFIELD.cpp_type = 1
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.name = "gainValue"
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.full_name = ".TaskActivityInfo.gainValue"
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.number = 4
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.index = 3
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.label = 1
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.has_default_value = false
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.default_value = 0
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.type = 5
TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD.cpp_type = 1
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.name = "expiryTime"
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.full_name = ".TaskActivityInfo.expiryTime"
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.number = 5
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.index = 4
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.label = 2
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.has_default_value = false
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.default_value = 0
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.type = 5
TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD.cpp_type = 1
TaskModule_pb.TASKACTIVITYINFO_MSG.name = "TaskActivityInfo"
TaskModule_pb.TASKACTIVITYINFO_MSG.full_name = ".TaskActivityInfo"
TaskModule_pb.TASKACTIVITYINFO_MSG.nested_types = {}
TaskModule_pb.TASKACTIVITYINFO_MSG.enum_types = {}
TaskModule_pb.TASKACTIVITYINFO_MSG.fields = {
	TaskModule_pb.TASKACTIVITYINFOTYPEIDFIELD,
	TaskModule_pb.TASKACTIVITYINFODEFINEIDFIELD,
	TaskModule_pb.TASKACTIVITYINFOVALUEFIELD,
	TaskModule_pb.TASKACTIVITYINFOGAINVALUEFIELD,
	TaskModule_pb.TASKACTIVITYINFOEXPIRYTIMEFIELD
}
TaskModule_pb.TASKACTIVITYINFO_MSG.is_extendable = false
TaskModule_pb.TASKACTIVITYINFO_MSG.extensions = {}
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.name = "taskId"
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.full_name = ".FinishReadTaskRequest.taskId"
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.number = 1
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.index = 0
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.label = 1
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.has_default_value = false
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.default_value = 0
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.type = 5
TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD.cpp_type = 1
TaskModule_pb.FINISHREADTASKREQUEST_MSG.name = "FinishReadTaskRequest"
TaskModule_pb.FINISHREADTASKREQUEST_MSG.full_name = ".FinishReadTaskRequest"
TaskModule_pb.FINISHREADTASKREQUEST_MSG.nested_types = {}
TaskModule_pb.FINISHREADTASKREQUEST_MSG.enum_types = {}
TaskModule_pb.FINISHREADTASKREQUEST_MSG.fields = {
	TaskModule_pb.FINISHREADTASKREQUESTTASKIDFIELD
}
TaskModule_pb.FINISHREADTASKREQUEST_MSG.is_extendable = false
TaskModule_pb.FINISHREADTASKREQUEST_MSG.extensions = {}
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.name = "typeIds"
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.full_name = ".GetTaskInfoRequest.typeIds"
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.number = 1
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.index = 0
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.label = 3
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.has_default_value = false
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.default_value = {}
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.type = 13
TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD.cpp_type = 3
TaskModule_pb.GETTASKINFOREQUEST_MSG.name = "GetTaskInfoRequest"
TaskModule_pb.GETTASKINFOREQUEST_MSG.full_name = ".GetTaskInfoRequest"
TaskModule_pb.GETTASKINFOREQUEST_MSG.nested_types = {}
TaskModule_pb.GETTASKINFOREQUEST_MSG.enum_types = {}
TaskModule_pb.GETTASKINFOREQUEST_MSG.fields = {
	TaskModule_pb.GETTASKINFOREQUESTTYPEIDSFIELD
}
TaskModule_pb.GETTASKINFOREQUEST_MSG.is_extendable = false
TaskModule_pb.GETTASKINFOREQUEST_MSG.extensions = {}
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.name = "typeId"
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.full_name = ".FinishAllTaskRequest.typeId"
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.number = 1
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.index = 0
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.name = "minTypeId"
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.full_name = ".FinishAllTaskRequest.minTypeId"
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.number = 2
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.index = 1
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.name = "taskIds"
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.full_name = ".FinishAllTaskRequest.taskIds"
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.number = 3
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.index = 2
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.label = 3
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.default_value = {}
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.type = 5
TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.name = "activityId"
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.full_name = ".FinishAllTaskRequest.activityId"
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.number = 4
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.index = 3
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREQUEST_MSG.name = "FinishAllTaskRequest"
TaskModule_pb.FINISHALLTASKREQUEST_MSG.full_name = ".FinishAllTaskRequest"
TaskModule_pb.FINISHALLTASKREQUEST_MSG.nested_types = {}
TaskModule_pb.FINISHALLTASKREQUEST_MSG.enum_types = {}
TaskModule_pb.FINISHALLTASKREQUEST_MSG.fields = {
	TaskModule_pb.FINISHALLTASKREQUESTTYPEIDFIELD,
	TaskModule_pb.FINISHALLTASKREQUESTMINTYPEIDFIELD,
	TaskModule_pb.FINISHALLTASKREQUESTTASKIDSFIELD,
	TaskModule_pb.FINISHALLTASKREQUESTACTIVITYIDFIELD
}
TaskModule_pb.FINISHALLTASKREQUEST_MSG.is_extendable = false
TaskModule_pb.FINISHALLTASKREQUEST_MSG.extensions = {}
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.name = "typeId"
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.full_name = ".GetTaskActivityBonusReply.typeId"
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.number = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.index = 0
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.label = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.has_default_value = false
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.default_value = 0
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.type = 5
TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.cpp_type = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.name = "defineId"
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.full_name = ".GetTaskActivityBonusReply.defineId"
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.number = 2
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.index = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.label = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.has_default_value = false
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.default_value = 0
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.type = 5
TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.cpp_type = 1
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.name = "GetTaskActivityBonusReply"
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.full_name = ".GetTaskActivityBonusReply"
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.nested_types = {}
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.enum_types = {}
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.fields = {
	TaskModule_pb.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD,
	TaskModule_pb.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD
}
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.is_extendable = false
TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG.extensions = {}
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.name = "typeId"
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.full_name = ".FinishAllTaskReply.typeId"
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.number = 1
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.index = 0
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.name = "minTypeId"
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.full_name = ".FinishAllTaskReply.minTypeId"
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.number = 2
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.index = 1
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.name = "taskIds"
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.full_name = ".FinishAllTaskReply.taskIds"
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.number = 3
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.index = 2
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.label = 3
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.default_value = {}
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.type = 5
TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.name = "activityId"
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.full_name = ".FinishAllTaskReply.activityId"
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.number = 4
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.index = 3
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.label = 1
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.has_default_value = false
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.default_value = 0
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.type = 5
TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD.cpp_type = 1
TaskModule_pb.FINISHALLTASKREPLY_MSG.name = "FinishAllTaskReply"
TaskModule_pb.FINISHALLTASKREPLY_MSG.full_name = ".FinishAllTaskReply"
TaskModule_pb.FINISHALLTASKREPLY_MSG.nested_types = {}
TaskModule_pb.FINISHALLTASKREPLY_MSG.enum_types = {}
TaskModule_pb.FINISHALLTASKREPLY_MSG.fields = {
	TaskModule_pb.FINISHALLTASKREPLYTYPEIDFIELD,
	TaskModule_pb.FINISHALLTASKREPLYMINTYPEIDFIELD,
	TaskModule_pb.FINISHALLTASKREPLYTASKIDSFIELD,
	TaskModule_pb.FINISHALLTASKREPLYACTIVITYIDFIELD
}
TaskModule_pb.FINISHALLTASKREPLY_MSG.is_extendable = false
TaskModule_pb.FINISHALLTASKREPLY_MSG.extensions = {}
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.name = "typeId"
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.full_name = ".GetTaskActivityBonusRequest.typeId"
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.number = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.index = 0
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.label = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.has_default_value = false
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.default_value = 0
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.type = 5
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.cpp_type = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.name = "defineId"
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.full_name = ".GetTaskActivityBonusRequest.defineId"
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.number = 2
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.index = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.label = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.has_default_value = false
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.default_value = 0
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.type = 5
TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.cpp_type = 1
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.name = "GetTaskActivityBonusRequest"
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.full_name = ".GetTaskActivityBonusRequest"
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.nested_types = {}
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.enum_types = {}
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.fields = {
	TaskModule_pb.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD,
	TaskModule_pb.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD
}
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.is_extendable = false
TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG.extensions = {}
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.name = "taskId"
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.full_name = ".FinishReadTaskReply.taskId"
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.number = 1
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.index = 0
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.label = 1
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.has_default_value = false
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.default_value = 0
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.type = 5
TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD.cpp_type = 1
TaskModule_pb.FINISHREADTASKREPLY_MSG.name = "FinishReadTaskReply"
TaskModule_pb.FINISHREADTASKREPLY_MSG.full_name = ".FinishReadTaskReply"
TaskModule_pb.FINISHREADTASKREPLY_MSG.nested_types = {}
TaskModule_pb.FINISHREADTASKREPLY_MSG.enum_types = {}
TaskModule_pb.FINISHREADTASKREPLY_MSG.fields = {
	TaskModule_pb.FINISHREADTASKREPLYTASKIDFIELD
}
TaskModule_pb.FINISHREADTASKREPLY_MSG.is_extendable = false
TaskModule_pb.FINISHREADTASKREPLY_MSG.extensions = {}
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.name = "taskInfo"
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.full_name = ".UpdateTaskPush.taskInfo"
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.number = 1
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.index = 0
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.label = 3
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.has_default_value = false
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.default_value = {}
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.message_type = TaskModule_pb.TASK_MSG
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.type = 11
TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD.cpp_type = 10
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.name = "activityInfo"
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.full_name = ".UpdateTaskPush.activityInfo"
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.number = 2
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.index = 1
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.label = 3
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.has_default_value = false
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.default_value = {}
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.message_type = TaskModule_pb.TASKACTIVITYINFO_MSG
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.type = 11
TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD.cpp_type = 10
TaskModule_pb.UPDATETASKPUSH_MSG.name = "UpdateTaskPush"
TaskModule_pb.UPDATETASKPUSH_MSG.full_name = ".UpdateTaskPush"
TaskModule_pb.UPDATETASKPUSH_MSG.nested_types = {}
TaskModule_pb.UPDATETASKPUSH_MSG.enum_types = {}
TaskModule_pb.UPDATETASKPUSH_MSG.fields = {
	TaskModule_pb.UPDATETASKPUSHTASKINFOFIELD,
	TaskModule_pb.UPDATETASKPUSHACTIVITYINFOFIELD
}
TaskModule_pb.UPDATETASKPUSH_MSG.is_extendable = false
TaskModule_pb.UPDATETASKPUSH_MSG.extensions = {}
TaskModule_pb.FINISHTASKREQUESTIDFIELD.name = "id"
TaskModule_pb.FINISHTASKREQUESTIDFIELD.full_name = ".FinishTaskRequest.id"
TaskModule_pb.FINISHTASKREQUESTIDFIELD.number = 1
TaskModule_pb.FINISHTASKREQUESTIDFIELD.index = 0
TaskModule_pb.FINISHTASKREQUESTIDFIELD.label = 2
TaskModule_pb.FINISHTASKREQUESTIDFIELD.has_default_value = false
TaskModule_pb.FINISHTASKREQUESTIDFIELD.default_value = 0
TaskModule_pb.FINISHTASKREQUESTIDFIELD.type = 5
TaskModule_pb.FINISHTASKREQUESTIDFIELD.cpp_type = 1
TaskModule_pb.FINISHTASKREQUEST_MSG.name = "FinishTaskRequest"
TaskModule_pb.FINISHTASKREQUEST_MSG.full_name = ".FinishTaskRequest"
TaskModule_pb.FINISHTASKREQUEST_MSG.nested_types = {}
TaskModule_pb.FINISHTASKREQUEST_MSG.enum_types = {}
TaskModule_pb.FINISHTASKREQUEST_MSG.fields = {
	TaskModule_pb.FINISHTASKREQUESTIDFIELD
}
TaskModule_pb.FINISHTASKREQUEST_MSG.is_extendable = false
TaskModule_pb.FINISHTASKREQUEST_MSG.extensions = {}
TaskModule_pb.FINISHTASKREPLYIDFIELD.name = "id"
TaskModule_pb.FINISHTASKREPLYIDFIELD.full_name = ".FinishTaskReply.id"
TaskModule_pb.FINISHTASKREPLYIDFIELD.number = 1
TaskModule_pb.FINISHTASKREPLYIDFIELD.index = 0
TaskModule_pb.FINISHTASKREPLYIDFIELD.label = 1
TaskModule_pb.FINISHTASKREPLYIDFIELD.has_default_value = false
TaskModule_pb.FINISHTASKREPLYIDFIELD.default_value = 0
TaskModule_pb.FINISHTASKREPLYIDFIELD.type = 5
TaskModule_pb.FINISHTASKREPLYIDFIELD.cpp_type = 1
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.name = "finishCount"
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.full_name = ".FinishTaskReply.finishCount"
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.number = 2
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.index = 1
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.label = 1
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.has_default_value = false
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.default_value = 0
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.type = 5
TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD.cpp_type = 1
TaskModule_pb.FINISHTASKREPLY_MSG.name = "FinishTaskReply"
TaskModule_pb.FINISHTASKREPLY_MSG.full_name = ".FinishTaskReply"
TaskModule_pb.FINISHTASKREPLY_MSG.nested_types = {}
TaskModule_pb.FINISHTASKREPLY_MSG.enum_types = {}
TaskModule_pb.FINISHTASKREPLY_MSG.fields = {
	TaskModule_pb.FINISHTASKREPLYIDFIELD,
	TaskModule_pb.FINISHTASKREPLYFINISHCOUNTFIELD
}
TaskModule_pb.FINISHTASKREPLY_MSG.is_extendable = false
TaskModule_pb.FINISHTASKREPLY_MSG.extensions = {}
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.name = "taskIds"
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.full_name = ".DeleteTaskPush.taskIds"
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.number = 1
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.index = 0
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.label = 3
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.has_default_value = false
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.default_value = {}
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.type = 5
TaskModule_pb.DELETETASKPUSHTASKIDSFIELD.cpp_type = 1
TaskModule_pb.DELETETASKPUSH_MSG.name = "DeleteTaskPush"
TaskModule_pb.DELETETASKPUSH_MSG.full_name = ".DeleteTaskPush"
TaskModule_pb.DELETETASKPUSH_MSG.nested_types = {}
TaskModule_pb.DELETETASKPUSH_MSG.enum_types = {}
TaskModule_pb.DELETETASKPUSH_MSG.fields = {
	TaskModule_pb.DELETETASKPUSHTASKIDSFIELD
}
TaskModule_pb.DELETETASKPUSH_MSG.is_extendable = false
TaskModule_pb.DELETETASKPUSH_MSG.extensions = {}
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.name = "taskInfo"
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.full_name = ".GetTaskInfoReply.taskInfo"
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.number = 1
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.index = 0
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.label = 3
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.has_default_value = false
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.default_value = {}
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.message_type = TaskModule_pb.TASK_MSG
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.type = 11
TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD.cpp_type = 10
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.name = "activityInfo"
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.full_name = ".GetTaskInfoReply.activityInfo"
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.number = 2
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.index = 1
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.label = 3
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.has_default_value = false
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.default_value = {}
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.message_type = TaskModule_pb.TASKACTIVITYINFO_MSG
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.type = 11
TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD.cpp_type = 10
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.name = "typeIds"
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.full_name = ".GetTaskInfoReply.typeIds"
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.number = 3
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.index = 2
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.label = 3
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.has_default_value = false
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.default_value = {}
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.type = 13
TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD.cpp_type = 3
TaskModule_pb.GETTASKINFOREPLY_MSG.name = "GetTaskInfoReply"
TaskModule_pb.GETTASKINFOREPLY_MSG.full_name = ".GetTaskInfoReply"
TaskModule_pb.GETTASKINFOREPLY_MSG.nested_types = {}
TaskModule_pb.GETTASKINFOREPLY_MSG.enum_types = {}
TaskModule_pb.GETTASKINFOREPLY_MSG.fields = {
	TaskModule_pb.GETTASKINFOREPLYTASKINFOFIELD,
	TaskModule_pb.GETTASKINFOREPLYACTIVITYINFOFIELD,
	TaskModule_pb.GETTASKINFOREPLYTYPEIDSFIELD
}
TaskModule_pb.GETTASKINFOREPLY_MSG.is_extendable = false
TaskModule_pb.GETTASKINFOREPLY_MSG.extensions = {}
TaskModule_pb.DeleteTaskPush = protobuf.Message(TaskModule_pb.DELETETASKPUSH_MSG)
TaskModule_pb.FinishAllTaskReply = protobuf.Message(TaskModule_pb.FINISHALLTASKREPLY_MSG)
TaskModule_pb.FinishAllTaskRequest = protobuf.Message(TaskModule_pb.FINISHALLTASKREQUEST_MSG)
TaskModule_pb.FinishReadTaskReply = protobuf.Message(TaskModule_pb.FINISHREADTASKREPLY_MSG)
TaskModule_pb.FinishReadTaskRequest = protobuf.Message(TaskModule_pb.FINISHREADTASKREQUEST_MSG)
TaskModule_pb.FinishTaskReply = protobuf.Message(TaskModule_pb.FINISHTASKREPLY_MSG)
TaskModule_pb.FinishTaskRequest = protobuf.Message(TaskModule_pb.FINISHTASKREQUEST_MSG)
TaskModule_pb.GetTaskActivityBonusReply = protobuf.Message(TaskModule_pb.GETTASKACTIVITYBONUSREPLY_MSG)
TaskModule_pb.GetTaskActivityBonusRequest = protobuf.Message(TaskModule_pb.GETTASKACTIVITYBONUSREQUEST_MSG)
TaskModule_pb.GetTaskInfoReply = protobuf.Message(TaskModule_pb.GETTASKINFOREPLY_MSG)
TaskModule_pb.GetTaskInfoRequest = protobuf.Message(TaskModule_pb.GETTASKINFOREQUEST_MSG)
TaskModule_pb.Task = protobuf.Message(TaskModule_pb.TASK_MSG)
TaskModule_pb.TaskActivityInfo = protobuf.Message(TaskModule_pb.TASKACTIVITYINFO_MSG)
TaskModule_pb.UpdateTaskPush = protobuf.Message(TaskModule_pb.UPDATETASKPUSH_MSG)

return TaskModule_pb
