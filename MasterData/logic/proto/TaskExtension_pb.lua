-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/TaskExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.TaskExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.TaskLabel = protobuf.EnumDescriptor()
enum_item_descriptors.TaskLabel_Newbie = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Daily = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Weekly = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Challenge = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_TimeLimit = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Achievement = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Cup = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Tacit = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_RoguelikeWeekly = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_RoguelikeMonthly = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_RoguelikeFix = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_HouseDaily = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_HouseTask = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_SeasonCircle = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_SeasonWeekly = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_SeasonFix = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_GrowthPlan = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_AirStudio = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_ControlAction = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_ClipDollDaily = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_Home = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_SeasonDaily = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_ChapterReward = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_PowerChallenge = protobuf.EnumValueDescriptor()
enum_item_descriptors.TaskLabel_LevelReward = protobuf.EnumValueDescriptor()
type_descriptors.RewardReply = protobuf.Descriptor()
field_descriptors.RewardReply_tasks = protobuf.FieldDescriptor()
type_descriptors.RefreshPush = protobuf.Descriptor()
field_descriptors.RefreshPush_refresh = protobuf.FieldDescriptor()
type_descriptors.OnTaskSchedulePush = protobuf.Descriptor()
field_descriptors.OnTaskSchedulePush_task = protobuf.FieldDescriptor()
type_descriptors.ListTaskReply = protobuf.Descriptor()
field_descriptors.ListTaskReply_label = protobuf.FieldDescriptor()
field_descriptors.ListTaskReply_tasks = protobuf.FieldDescriptor()
type_descriptors.TaskNO = protobuf.Descriptor()
field_descriptors.TaskNO_id = protobuf.FieldDescriptor()
field_descriptors.TaskNO_count = protobuf.FieldDescriptor()
field_descriptors.TaskNO_finish = protobuf.FieldDescriptor()
type_descriptors.HomeTaskPush = protobuf.Descriptor()
field_descriptors.HomeTaskPush_taskId = protobuf.FieldDescriptor()
type_descriptors.RewardRequest = protobuf.Descriptor()
field_descriptors.RewardRequest_id = protobuf.FieldDescriptor()
type_descriptors.ListTaskRequest = protobuf.Descriptor()
field_descriptors.ListTaskRequest_label = protobuf.FieldDescriptor()
type_descriptors.RefreshTaskPush = protobuf.Descriptor()
field_descriptors.RefreshTaskPush_label = protobuf.FieldDescriptor()
field_descriptors.RefreshTaskPush_refresh = protobuf.FieldDescriptor()
enum_item_descriptors.TaskLabel_Newbie.name = "Newbie"
enum_item_descriptors.TaskLabel_Newbie.index = 0
enum_item_descriptors.TaskLabel_Newbie.number = 100001
enum_item_descriptors.TaskLabel_Daily.name = "Daily"
enum_item_descriptors.TaskLabel_Daily.index = 1
enum_item_descriptors.TaskLabel_Daily.number = 100002
enum_item_descriptors.TaskLabel_Weekly.name = "Weekly"
enum_item_descriptors.TaskLabel_Weekly.index = 2
enum_item_descriptors.TaskLabel_Weekly.number = 100003
enum_item_descriptors.TaskLabel_Challenge.name = "Challenge"
enum_item_descriptors.TaskLabel_Challenge.index = 3
enum_item_descriptors.TaskLabel_Challenge.number = 100004
enum_item_descriptors.TaskLabel_TimeLimit.name = "TimeLimit"
enum_item_descriptors.TaskLabel_TimeLimit.index = 4
enum_item_descriptors.TaskLabel_TimeLimit.number = 100005
enum_item_descriptors.TaskLabel_Achievement.name = "Achievement"
enum_item_descriptors.TaskLabel_Achievement.index = 5
enum_item_descriptors.TaskLabel_Achievement.number = 100006
enum_item_descriptors.TaskLabel_Cup.name = "Cup"
enum_item_descriptors.TaskLabel_Cup.index = 6
enum_item_descriptors.TaskLabel_Cup.number = 100007
enum_item_descriptors.TaskLabel_Tacit.name = "Tacit"
enum_item_descriptors.TaskLabel_Tacit.index = 7
enum_item_descriptors.TaskLabel_Tacit.number = 100008
enum_item_descriptors.TaskLabel_RoguelikeWeekly.name = "RoguelikeWeekly"
enum_item_descriptors.TaskLabel_RoguelikeWeekly.index = 8
enum_item_descriptors.TaskLabel_RoguelikeWeekly.number = 100011
enum_item_descriptors.TaskLabel_RoguelikeMonthly.name = "RoguelikeMonthly"
enum_item_descriptors.TaskLabel_RoguelikeMonthly.index = 9
enum_item_descriptors.TaskLabel_RoguelikeMonthly.number = 100012
enum_item_descriptors.TaskLabel_RoguelikeFix.name = "RoguelikeFix"
enum_item_descriptors.TaskLabel_RoguelikeFix.index = 10
enum_item_descriptors.TaskLabel_RoguelikeFix.number = 100013
enum_item_descriptors.TaskLabel_HouseDaily.name = "HouseDaily"
enum_item_descriptors.TaskLabel_HouseDaily.index = 11
enum_item_descriptors.TaskLabel_HouseDaily.number = 100021
enum_item_descriptors.TaskLabel_HouseTask.name = "HouseTask"
enum_item_descriptors.TaskLabel_HouseTask.index = 12
enum_item_descriptors.TaskLabel_HouseTask.number = 100022
enum_item_descriptors.TaskLabel_SeasonCircle.name = "SeasonCircle"
enum_item_descriptors.TaskLabel_SeasonCircle.index = 13
enum_item_descriptors.TaskLabel_SeasonCircle.number = 100031
enum_item_descriptors.TaskLabel_SeasonWeekly.name = "SeasonWeekly"
enum_item_descriptors.TaskLabel_SeasonWeekly.index = 14
enum_item_descriptors.TaskLabel_SeasonWeekly.number = 100032
enum_item_descriptors.TaskLabel_SeasonFix.name = "SeasonFix"
enum_item_descriptors.TaskLabel_SeasonFix.index = 15
enum_item_descriptors.TaskLabel_SeasonFix.number = 100033
enum_item_descriptors.TaskLabel_GrowthPlan.name = "GrowthPlan"
enum_item_descriptors.TaskLabel_GrowthPlan.index = 16
enum_item_descriptors.TaskLabel_GrowthPlan.number = 100034
enum_item_descriptors.TaskLabel_AirStudio.name = "AirStudio"
enum_item_descriptors.TaskLabel_AirStudio.index = 17
enum_item_descriptors.TaskLabel_AirStudio.number = 100035
enum_item_descriptors.TaskLabel_ControlAction.name = "ControlAction"
enum_item_descriptors.TaskLabel_ControlAction.index = 18
enum_item_descriptors.TaskLabel_ControlAction.number = 100036
enum_item_descriptors.TaskLabel_ClipDollDaily.name = "ClipDollDaily"
enum_item_descriptors.TaskLabel_ClipDollDaily.index = 19
enum_item_descriptors.TaskLabel_ClipDollDaily.number = 100037
enum_item_descriptors.TaskLabel_Home.name = "Home"
enum_item_descriptors.TaskLabel_Home.index = 20
enum_item_descriptors.TaskLabel_Home.number = 100038
enum_item_descriptors.TaskLabel_SeasonDaily.name = "SeasonDaily"
enum_item_descriptors.TaskLabel_SeasonDaily.index = 21
enum_item_descriptors.TaskLabel_SeasonDaily.number = 100039
enum_item_descriptors.TaskLabel_ChapterReward.name = "ChapterReward"
enum_item_descriptors.TaskLabel_ChapterReward.index = 22
enum_item_descriptors.TaskLabel_ChapterReward.number = 100040
enum_item_descriptors.TaskLabel_PowerChallenge.name = "PowerChallenge"
enum_item_descriptors.TaskLabel_PowerChallenge.index = 23
enum_item_descriptors.TaskLabel_PowerChallenge.number = 100041
enum_item_descriptors.TaskLabel_LevelReward.name = "LevelReward"
enum_item_descriptors.TaskLabel_LevelReward.index = 24
enum_item_descriptors.TaskLabel_LevelReward.number = 100042
type_descriptors.TaskLabel.name = "TaskLabel"
type_descriptors.TaskLabel.full_name = ".TaskLabel"
type_descriptors.TaskLabel.values = {
	enum_item_descriptors.TaskLabel_Newbie,
	enum_item_descriptors.TaskLabel_Daily,
	enum_item_descriptors.TaskLabel_Weekly,
	enum_item_descriptors.TaskLabel_Challenge,
	enum_item_descriptors.TaskLabel_TimeLimit,
	enum_item_descriptors.TaskLabel_Achievement,
	enum_item_descriptors.TaskLabel_Cup,
	enum_item_descriptors.TaskLabel_Tacit,
	enum_item_descriptors.TaskLabel_RoguelikeWeekly,
	enum_item_descriptors.TaskLabel_RoguelikeMonthly,
	enum_item_descriptors.TaskLabel_RoguelikeFix,
	enum_item_descriptors.TaskLabel_HouseDaily,
	enum_item_descriptors.TaskLabel_HouseTask,
	enum_item_descriptors.TaskLabel_SeasonCircle,
	enum_item_descriptors.TaskLabel_SeasonWeekly,
	enum_item_descriptors.TaskLabel_SeasonFix,
	enum_item_descriptors.TaskLabel_GrowthPlan,
	enum_item_descriptors.TaskLabel_AirStudio,
	enum_item_descriptors.TaskLabel_ControlAction,
	enum_item_descriptors.TaskLabel_ClipDollDaily,
	enum_item_descriptors.TaskLabel_Home,
	enum_item_descriptors.TaskLabel_SeasonDaily,
	enum_item_descriptors.TaskLabel_ChapterReward,
	enum_item_descriptors.TaskLabel_PowerChallenge,
	enum_item_descriptors.TaskLabel_LevelReward
}
field_descriptors.RewardReply_tasks.name = "tasks"
field_descriptors.RewardReply_tasks.full_name = ".RewardReply.tasks"
field_descriptors.RewardReply_tasks.number = 1
field_descriptors.RewardReply_tasks.index = 0
field_descriptors.RewardReply_tasks.label = 3
field_descriptors.RewardReply_tasks.has_default_value = false
field_descriptors.RewardReply_tasks.default_value = {}
field_descriptors.RewardReply_tasks.type = 5
field_descriptors.RewardReply_tasks.cpp_type = 1
type_descriptors.RewardReply.name = "RewardReply"
type_descriptors.RewardReply.full_name = ".RewardReply"
type_descriptors.RewardReply.nested_types = {}
type_descriptors.RewardReply.enum_types = {}
type_descriptors.RewardReply.fields = {
	field_descriptors.RewardReply_tasks
}
type_descriptors.RewardReply.is_extendable = false
type_descriptors.RewardReply.extensions = {}
field_descriptors.RefreshPush_refresh.name = "refresh"
field_descriptors.RefreshPush_refresh.full_name = ".RefreshPush.refresh"
field_descriptors.RefreshPush_refresh.number = 1
field_descriptors.RefreshPush_refresh.index = 0
field_descriptors.RefreshPush_refresh.label = 1
field_descriptors.RefreshPush_refresh.has_default_value = false
field_descriptors.RefreshPush_refresh.default_value = false
field_descriptors.RefreshPush_refresh.type = 8
field_descriptors.RefreshPush_refresh.cpp_type = 7
type_descriptors.RefreshPush.name = "RefreshPush"
type_descriptors.RefreshPush.full_name = ".RefreshPush"
type_descriptors.RefreshPush.nested_types = {}
type_descriptors.RefreshPush.enum_types = {}
type_descriptors.RefreshPush.fields = {
	field_descriptors.RefreshPush_refresh
}
type_descriptors.RefreshPush.is_extendable = false
type_descriptors.RefreshPush.extensions = {}
field_descriptors.OnTaskSchedulePush_task.name = "task"
field_descriptors.OnTaskSchedulePush_task.full_name = ".OnTaskSchedulePush.task"
field_descriptors.OnTaskSchedulePush_task.number = 1
field_descriptors.OnTaskSchedulePush_task.index = 0
field_descriptors.OnTaskSchedulePush_task.label = 1
field_descriptors.OnTaskSchedulePush_task.has_default_value = false
field_descriptors.OnTaskSchedulePush_task.default_value = nil
field_descriptors.OnTaskSchedulePush_task.message_type = type_descriptors.TaskNO
field_descriptors.OnTaskSchedulePush_task.type = 11
field_descriptors.OnTaskSchedulePush_task.cpp_type = 10
type_descriptors.OnTaskSchedulePush.name = "OnTaskSchedulePush"
type_descriptors.OnTaskSchedulePush.full_name = ".OnTaskSchedulePush"
type_descriptors.OnTaskSchedulePush.nested_types = {}
type_descriptors.OnTaskSchedulePush.enum_types = {}
type_descriptors.OnTaskSchedulePush.fields = {
	field_descriptors.OnTaskSchedulePush_task
}
type_descriptors.OnTaskSchedulePush.is_extendable = false
type_descriptors.OnTaskSchedulePush.extensions = {}
field_descriptors.ListTaskReply_label.name = "label"
field_descriptors.ListTaskReply_label.full_name = ".ListTaskReply.label"
field_descriptors.ListTaskReply_label.number = 1
field_descriptors.ListTaskReply_label.index = 0
field_descriptors.ListTaskReply_label.label = 2
field_descriptors.ListTaskReply_label.has_default_value = false
field_descriptors.ListTaskReply_label.default_value = nil
field_descriptors.ListTaskReply_label.enum_type = type_descriptors.TaskLabel
field_descriptors.ListTaskReply_label.type = 14
field_descriptors.ListTaskReply_label.cpp_type = 8
field_descriptors.ListTaskReply_tasks.name = "tasks"
field_descriptors.ListTaskReply_tasks.full_name = ".ListTaskReply.tasks"
field_descriptors.ListTaskReply_tasks.number = 2
field_descriptors.ListTaskReply_tasks.index = 1
field_descriptors.ListTaskReply_tasks.label = 3
field_descriptors.ListTaskReply_tasks.has_default_value = false
field_descriptors.ListTaskReply_tasks.default_value = {}
field_descriptors.ListTaskReply_tasks.message_type = type_descriptors.TaskNO
field_descriptors.ListTaskReply_tasks.type = 11
field_descriptors.ListTaskReply_tasks.cpp_type = 10
type_descriptors.ListTaskReply.name = "ListTaskReply"
type_descriptors.ListTaskReply.full_name = ".ListTaskReply"
type_descriptors.ListTaskReply.nested_types = {}
type_descriptors.ListTaskReply.enum_types = {}
type_descriptors.ListTaskReply.fields = {
	field_descriptors.ListTaskReply_label,
	field_descriptors.ListTaskReply_tasks
}
type_descriptors.ListTaskReply.is_extendable = false
type_descriptors.ListTaskReply.extensions = {}
field_descriptors.TaskNO_id.name = "id"
field_descriptors.TaskNO_id.full_name = ".TaskNO.id"
field_descriptors.TaskNO_id.number = 1
field_descriptors.TaskNO_id.index = 0
field_descriptors.TaskNO_id.label = 1
field_descriptors.TaskNO_id.has_default_value = false
field_descriptors.TaskNO_id.default_value = 0
field_descriptors.TaskNO_id.type = 5
field_descriptors.TaskNO_id.cpp_type = 1
field_descriptors.TaskNO_count.name = "count"
field_descriptors.TaskNO_count.full_name = ".TaskNO.count"
field_descriptors.TaskNO_count.number = 2
field_descriptors.TaskNO_count.index = 1
field_descriptors.TaskNO_count.label = 1
field_descriptors.TaskNO_count.has_default_value = false
field_descriptors.TaskNO_count.default_value = 0
field_descriptors.TaskNO_count.type = 5
field_descriptors.TaskNO_count.cpp_type = 1
field_descriptors.TaskNO_finish.name = "finish"
field_descriptors.TaskNO_finish.full_name = ".TaskNO.finish"
field_descriptors.TaskNO_finish.number = 3
field_descriptors.TaskNO_finish.index = 2
field_descriptors.TaskNO_finish.label = 1
field_descriptors.TaskNO_finish.has_default_value = false
field_descriptors.TaskNO_finish.default_value = false
field_descriptors.TaskNO_finish.type = 8
field_descriptors.TaskNO_finish.cpp_type = 7
type_descriptors.TaskNO.name = "TaskNO"
type_descriptors.TaskNO.full_name = ".TaskNO"
type_descriptors.TaskNO.nested_types = {}
type_descriptors.TaskNO.enum_types = {}
type_descriptors.TaskNO.fields = {
	field_descriptors.TaskNO_id,
	field_descriptors.TaskNO_count,
	field_descriptors.TaskNO_finish
}
type_descriptors.TaskNO.is_extendable = false
type_descriptors.TaskNO.extensions = {}
field_descriptors.HomeTaskPush_taskId.name = "taskId"
field_descriptors.HomeTaskPush_taskId.full_name = ".HomeTaskPush.taskId"
field_descriptors.HomeTaskPush_taskId.number = 1
field_descriptors.HomeTaskPush_taskId.index = 0
field_descriptors.HomeTaskPush_taskId.label = 2
field_descriptors.HomeTaskPush_taskId.has_default_value = false
field_descriptors.HomeTaskPush_taskId.default_value = 0
field_descriptors.HomeTaskPush_taskId.type = 5
field_descriptors.HomeTaskPush_taskId.cpp_type = 1
type_descriptors.HomeTaskPush.name = "HomeTaskPush"
type_descriptors.HomeTaskPush.full_name = ".HomeTaskPush"
type_descriptors.HomeTaskPush.nested_types = {}
type_descriptors.HomeTaskPush.enum_types = {}
type_descriptors.HomeTaskPush.fields = {
	field_descriptors.HomeTaskPush_taskId
}
type_descriptors.HomeTaskPush.is_extendable = false
type_descriptors.HomeTaskPush.extensions = {}
field_descriptors.RewardRequest_id.name = "id"
field_descriptors.RewardRequest_id.full_name = ".RewardRequest.id"
field_descriptors.RewardRequest_id.number = 1
field_descriptors.RewardRequest_id.index = 0
field_descriptors.RewardRequest_id.label = 3
field_descriptors.RewardRequest_id.has_default_value = false
field_descriptors.RewardRequest_id.default_value = {}
field_descriptors.RewardRequest_id.type = 5
field_descriptors.RewardRequest_id.cpp_type = 1
type_descriptors.RewardRequest.name = "RewardRequest"
type_descriptors.RewardRequest.full_name = ".RewardRequest"
type_descriptors.RewardRequest.nested_types = {}
type_descriptors.RewardRequest.enum_types = {}
type_descriptors.RewardRequest.fields = {
	field_descriptors.RewardRequest_id
}
type_descriptors.RewardRequest.is_extendable = false
type_descriptors.RewardRequest.extensions = {}
field_descriptors.ListTaskRequest_label.name = "label"
field_descriptors.ListTaskRequest_label.full_name = ".ListTaskRequest.label"
field_descriptors.ListTaskRequest_label.number = 1
field_descriptors.ListTaskRequest_label.index = 0
field_descriptors.ListTaskRequest_label.label = 2
field_descriptors.ListTaskRequest_label.has_default_value = false
field_descriptors.ListTaskRequest_label.default_value = nil
field_descriptors.ListTaskRequest_label.enum_type = type_descriptors.TaskLabel
field_descriptors.ListTaskRequest_label.type = 14
field_descriptors.ListTaskRequest_label.cpp_type = 8
type_descriptors.ListTaskRequest.name = "ListTaskRequest"
type_descriptors.ListTaskRequest.full_name = ".ListTaskRequest"
type_descriptors.ListTaskRequest.nested_types = {}
type_descriptors.ListTaskRequest.enum_types = {}
type_descriptors.ListTaskRequest.fields = {
	field_descriptors.ListTaskRequest_label
}
type_descriptors.ListTaskRequest.is_extendable = false
type_descriptors.ListTaskRequest.extensions = {}
field_descriptors.RefreshTaskPush_label.name = "label"
field_descriptors.RefreshTaskPush_label.full_name = ".RefreshTaskPush.label"
field_descriptors.RefreshTaskPush_label.number = 1
field_descriptors.RefreshTaskPush_label.index = 0
field_descriptors.RefreshTaskPush_label.label = 2
field_descriptors.RefreshTaskPush_label.has_default_value = false
field_descriptors.RefreshTaskPush_label.default_value = nil
field_descriptors.RefreshTaskPush_label.enum_type = type_descriptors.TaskLabel
field_descriptors.RefreshTaskPush_label.type = 14
field_descriptors.RefreshTaskPush_label.cpp_type = 8
field_descriptors.RefreshTaskPush_refresh.name = "refresh"
field_descriptors.RefreshTaskPush_refresh.full_name = ".RefreshTaskPush.refresh"
field_descriptors.RefreshTaskPush_refresh.number = 2
field_descriptors.RefreshTaskPush_refresh.index = 1
field_descriptors.RefreshTaskPush_refresh.label = 2
field_descriptors.RefreshTaskPush_refresh.has_default_value = false
field_descriptors.RefreshTaskPush_refresh.default_value = false
field_descriptors.RefreshTaskPush_refresh.type = 8
field_descriptors.RefreshTaskPush_refresh.cpp_type = 7
type_descriptors.RefreshTaskPush.name = "RefreshTaskPush"
type_descriptors.RefreshTaskPush.full_name = ".RefreshTaskPush"
type_descriptors.RefreshTaskPush.nested_types = {}
type_descriptors.RefreshTaskPush.enum_types = {}
type_descriptors.RefreshTaskPush.fields = {
	field_descriptors.RefreshTaskPush_label,
	field_descriptors.RefreshTaskPush_refresh
}
type_descriptors.RefreshTaskPush.is_extendable = false
type_descriptors.RefreshTaskPush.extensions = {}
TaskLabel = {
	Challenge = 100004,
	AirStudio = 100035,
	HouseTask = 100022,
	RoguelikeFix = 100013,
	Tacit = 100008,
	ControlAction = 100036,
	Newbie = 100001,
	GrowthPlan = 100034,
	Cup = 100007,
	HouseDaily = 100021,
	ClipDollDaily = 100037,
	SeasonDaily = 100039,
	TimeLimit = 100005,
	Daily = 100002,
	Home = 100038,
	PowerChallenge = 100041,
	RoguelikeWeekly = 100011,
	ChapterReward = 100040,
	LevelReward = 100042,
	RoguelikeMonthly = 100012,
	SeasonCircle = 100031,
	Achievement = 100006,
	SeasonWeekly = 100032,
	SeasonFix = 100033,
	Weekly = 100003
}
HomeTaskPush = protobuf.Message(type_descriptors.HomeTaskPush)
ListTaskReply = protobuf.Message(type_descriptors.ListTaskReply)
ListTaskRequest = protobuf.Message(type_descriptors.ListTaskRequest)
OnTaskSchedulePush = protobuf.Message(type_descriptors.OnTaskSchedulePush)
RefreshPush = protobuf.Message(type_descriptors.RefreshPush)
RefreshTaskPush = protobuf.Message(type_descriptors.RefreshTaskPush)
RewardReply = protobuf.Message(type_descriptors.RewardReply)
RewardRequest = protobuf.Message(type_descriptors.RewardRequest)
TaskNO = protobuf.Message(type_descriptors.TaskNO)

return _G["logic.proto.TaskExtension_pb"]
