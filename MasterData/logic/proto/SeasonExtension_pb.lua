-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/SeasonExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.TaskExtension = require("logic.proto.TaskExtension_pb")

module("logic.proto.SeasonExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.SeasonInfoRequest = protobuf.Descriptor()
type_descriptors.UnlockVipReply = protobuf.Descriptor()
type_descriptors.ReportRequest = protobuf.Descriptor()
type_descriptors.SeasonListTaskReply = protobuf.Descriptor()
field_descriptors.SeasonListTaskReply_tasks = protobuf.FieldDescriptor()
field_descriptors.SeasonListTaskReply_scheduleRewards = protobuf.FieldDescriptor()
type_descriptors.UpgradeRequest = protobuf.Descriptor()
field_descriptors.UpgradeRequest_lv = protobuf.FieldDescriptor()
type_descriptors.TakeTaskPointReply = protobuf.Descriptor()
field_descriptors.TakeTaskPointReply_ids = protobuf.FieldDescriptor()
type_descriptors.ReceiveScheduleRewardReply = protobuf.Descriptor()
field_descriptors.ReceiveScheduleRewardReply_ids = protobuf.FieldDescriptor()
type_descriptors.TakeLvRewardRequest = protobuf.Descriptor()
field_descriptors.TakeLvRewardRequest_lv = protobuf.FieldDescriptor()
type_descriptors.ReportReply = protobuf.Descriptor()
field_descriptors.ReportReply_history = protobuf.FieldDescriptor()
field_descriptors.ReportReply_tasks = protobuf.FieldDescriptor()
type_descriptors.TakeLvRewardReply = protobuf.Descriptor()
type_descriptors.SeasonSettle = protobuf.Descriptor()
field_descriptors.SeasonSettle_id = protobuf.FieldDescriptor()
field_descriptors.SeasonSettle_lv = protobuf.FieldDescriptor()
field_descriptors.SeasonSettle_point = protobuf.FieldDescriptor()
field_descriptors.SeasonSettle_taskPoint = protobuf.FieldDescriptor()
type_descriptors.UpgradeReply = protobuf.Descriptor()
type_descriptors.SeasonInfoReply = protobuf.Descriptor()
field_descriptors.SeasonInfoReply_id = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_lv = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_vip = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_point = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_today = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_lvs = protobuf.FieldDescriptor()
field_descriptors.SeasonInfoReply_vipLvs = protobuf.FieldDescriptor()
type_descriptors.ReceiveScheduleRewardRequest = protobuf.Descriptor()
field_descriptors.ReceiveScheduleRewardRequest_ids = protobuf.FieldDescriptor()
type_descriptors.CircleTaskNO = protobuf.Descriptor()
field_descriptors.CircleTaskNO_id = protobuf.FieldDescriptor()
field_descriptors.CircleTaskNO_todayPoint = protobuf.FieldDescriptor()
field_descriptors.CircleTaskNO_cumulativePoint = protobuf.FieldDescriptor()
type_descriptors.TakeTaskPointRequest = protobuf.Descriptor()
field_descriptors.TakeTaskPointRequest_ids = protobuf.FieldDescriptor()
type_descriptors.PointPush = protobuf.Descriptor()
field_descriptors.PointPush_point = protobuf.FieldDescriptor()
field_descriptors.PointPush_taskId = protobuf.FieldDescriptor()
type_descriptors.SeasonListTaskRequest = protobuf.Descriptor()
type_descriptors.UnlockVipRequest = protobuf.Descriptor()
field_descriptors.UnlockVipRequest_type = protobuf.FieldDescriptor()
type_descriptors.SeasonInfoRequest.name = "SeasonInfoRequest"
type_descriptors.SeasonInfoRequest.full_name = ".SeasonInfoRequest"
type_descriptors.SeasonInfoRequest.nested_types = {}
type_descriptors.SeasonInfoRequest.enum_types = {}
type_descriptors.SeasonInfoRequest.fields = {}
type_descriptors.SeasonInfoRequest.is_extendable = false
type_descriptors.SeasonInfoRequest.extensions = {}
type_descriptors.UnlockVipReply.name = "UnlockVipReply"
type_descriptors.UnlockVipReply.full_name = ".UnlockVipReply"
type_descriptors.UnlockVipReply.nested_types = {}
type_descriptors.UnlockVipReply.enum_types = {}
type_descriptors.UnlockVipReply.fields = {}
type_descriptors.UnlockVipReply.is_extendable = false
type_descriptors.UnlockVipReply.extensions = {}
type_descriptors.ReportRequest.name = "ReportRequest"
type_descriptors.ReportRequest.full_name = ".ReportRequest"
type_descriptors.ReportRequest.nested_types = {}
type_descriptors.ReportRequest.enum_types = {}
type_descriptors.ReportRequest.fields = {}
type_descriptors.ReportRequest.is_extendable = false
type_descriptors.ReportRequest.extensions = {}
field_descriptors.SeasonListTaskReply_tasks.name = "tasks"
field_descriptors.SeasonListTaskReply_tasks.full_name = ".SeasonListTaskReply.tasks"
field_descriptors.SeasonListTaskReply_tasks.number = 1
field_descriptors.SeasonListTaskReply_tasks.index = 0
field_descriptors.SeasonListTaskReply_tasks.label = 3
field_descriptors.SeasonListTaskReply_tasks.has_default_value = false
field_descriptors.SeasonListTaskReply_tasks.default_value = {}
field_descriptors.SeasonListTaskReply_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.SeasonListTaskReply_tasks.type = 11
field_descriptors.SeasonListTaskReply_tasks.cpp_type = 10
field_descriptors.SeasonListTaskReply_scheduleRewards.name = "scheduleRewards"
field_descriptors.SeasonListTaskReply_scheduleRewards.full_name = ".SeasonListTaskReply.scheduleRewards"
field_descriptors.SeasonListTaskReply_scheduleRewards.number = 2
field_descriptors.SeasonListTaskReply_scheduleRewards.index = 1
field_descriptors.SeasonListTaskReply_scheduleRewards.label = 3
field_descriptors.SeasonListTaskReply_scheduleRewards.has_default_value = false
field_descriptors.SeasonListTaskReply_scheduleRewards.default_value = {}
field_descriptors.SeasonListTaskReply_scheduleRewards.type = 5
field_descriptors.SeasonListTaskReply_scheduleRewards.cpp_type = 1
type_descriptors.SeasonListTaskReply.name = "SeasonListTaskReply"
type_descriptors.SeasonListTaskReply.full_name = ".SeasonListTaskReply"
type_descriptors.SeasonListTaskReply.nested_types = {}
type_descriptors.SeasonListTaskReply.enum_types = {}
type_descriptors.SeasonListTaskReply.fields = {
	field_descriptors.SeasonListTaskReply_tasks,
	field_descriptors.SeasonListTaskReply_scheduleRewards
}
type_descriptors.SeasonListTaskReply.is_extendable = false
type_descriptors.SeasonListTaskReply.extensions = {}
field_descriptors.UpgradeRequest_lv.name = "lv"
field_descriptors.UpgradeRequest_lv.full_name = ".UpgradeRequest.lv"
field_descriptors.UpgradeRequest_lv.number = 1
field_descriptors.UpgradeRequest_lv.index = 0
field_descriptors.UpgradeRequest_lv.label = 1
field_descriptors.UpgradeRequest_lv.has_default_value = false
field_descriptors.UpgradeRequest_lv.default_value = 0
field_descriptors.UpgradeRequest_lv.type = 5
field_descriptors.UpgradeRequest_lv.cpp_type = 1
type_descriptors.UpgradeRequest.name = "UpgradeRequest"
type_descriptors.UpgradeRequest.full_name = ".UpgradeRequest"
type_descriptors.UpgradeRequest.nested_types = {}
type_descriptors.UpgradeRequest.enum_types = {}
type_descriptors.UpgradeRequest.fields = {
	field_descriptors.UpgradeRequest_lv
}
type_descriptors.UpgradeRequest.is_extendable = false
type_descriptors.UpgradeRequest.extensions = {}
field_descriptors.TakeTaskPointReply_ids.name = "ids"
field_descriptors.TakeTaskPointReply_ids.full_name = ".TakeTaskPointReply.ids"
field_descriptors.TakeTaskPointReply_ids.number = 1
field_descriptors.TakeTaskPointReply_ids.index = 0
field_descriptors.TakeTaskPointReply_ids.label = 3
field_descriptors.TakeTaskPointReply_ids.has_default_value = false
field_descriptors.TakeTaskPointReply_ids.default_value = {}
field_descriptors.TakeTaskPointReply_ids.type = 5
field_descriptors.TakeTaskPointReply_ids.cpp_type = 1
type_descriptors.TakeTaskPointReply.name = "TakeTaskPointReply"
type_descriptors.TakeTaskPointReply.full_name = ".TakeTaskPointReply"
type_descriptors.TakeTaskPointReply.nested_types = {}
type_descriptors.TakeTaskPointReply.enum_types = {}
type_descriptors.TakeTaskPointReply.fields = {
	field_descriptors.TakeTaskPointReply_ids
}
type_descriptors.TakeTaskPointReply.is_extendable = false
type_descriptors.TakeTaskPointReply.extensions = {}
field_descriptors.ReceiveScheduleRewardReply_ids.name = "ids"
field_descriptors.ReceiveScheduleRewardReply_ids.full_name = ".ReceiveScheduleRewardReply.ids"
field_descriptors.ReceiveScheduleRewardReply_ids.number = 1
field_descriptors.ReceiveScheduleRewardReply_ids.index = 0
field_descriptors.ReceiveScheduleRewardReply_ids.label = 3
field_descriptors.ReceiveScheduleRewardReply_ids.has_default_value = false
field_descriptors.ReceiveScheduleRewardReply_ids.default_value = {}
field_descriptors.ReceiveScheduleRewardReply_ids.type = 5
field_descriptors.ReceiveScheduleRewardReply_ids.cpp_type = 1
type_descriptors.ReceiveScheduleRewardReply.name = "ReceiveScheduleRewardReply"
type_descriptors.ReceiveScheduleRewardReply.full_name = ".ReceiveScheduleRewardReply"
type_descriptors.ReceiveScheduleRewardReply.nested_types = {}
type_descriptors.ReceiveScheduleRewardReply.enum_types = {}
type_descriptors.ReceiveScheduleRewardReply.fields = {
	field_descriptors.ReceiveScheduleRewardReply_ids
}
type_descriptors.ReceiveScheduleRewardReply.is_extendable = false
type_descriptors.ReceiveScheduleRewardReply.extensions = {}
field_descriptors.TakeLvRewardRequest_lv.name = "lv"
field_descriptors.TakeLvRewardRequest_lv.full_name = ".TakeLvRewardRequest.lv"
field_descriptors.TakeLvRewardRequest_lv.number = 1
field_descriptors.TakeLvRewardRequest_lv.index = 0
field_descriptors.TakeLvRewardRequest_lv.label = 1
field_descriptors.TakeLvRewardRequest_lv.has_default_value = false
field_descriptors.TakeLvRewardRequest_lv.default_value = 0
field_descriptors.TakeLvRewardRequest_lv.type = 5
field_descriptors.TakeLvRewardRequest_lv.cpp_type = 1
type_descriptors.TakeLvRewardRequest.name = "TakeLvRewardRequest"
type_descriptors.TakeLvRewardRequest.full_name = ".TakeLvRewardRequest"
type_descriptors.TakeLvRewardRequest.nested_types = {}
type_descriptors.TakeLvRewardRequest.enum_types = {}
type_descriptors.TakeLvRewardRequest.fields = {
	field_descriptors.TakeLvRewardRequest_lv
}
type_descriptors.TakeLvRewardRequest.is_extendable = false
type_descriptors.TakeLvRewardRequest.extensions = {}
field_descriptors.ReportReply_history.name = "history"
field_descriptors.ReportReply_history.full_name = ".ReportReply.history"
field_descriptors.ReportReply_history.number = 1
field_descriptors.ReportReply_history.index = 0
field_descriptors.ReportReply_history.label = 3
field_descriptors.ReportReply_history.has_default_value = false
field_descriptors.ReportReply_history.default_value = {}
field_descriptors.ReportReply_history.type = 5
field_descriptors.ReportReply_history.cpp_type = 1
field_descriptors.ReportReply_tasks.name = "tasks"
field_descriptors.ReportReply_tasks.full_name = ".ReportReply.tasks"
field_descriptors.ReportReply_tasks.number = 2
field_descriptors.ReportReply_tasks.index = 1
field_descriptors.ReportReply_tasks.label = 3
field_descriptors.ReportReply_tasks.has_default_value = false
field_descriptors.ReportReply_tasks.default_value = {}
field_descriptors.ReportReply_tasks.message_type = type_descriptors.CircleTaskNO
field_descriptors.ReportReply_tasks.type = 11
field_descriptors.ReportReply_tasks.cpp_type = 10
type_descriptors.ReportReply.name = "ReportReply"
type_descriptors.ReportReply.full_name = ".ReportReply"
type_descriptors.ReportReply.nested_types = {}
type_descriptors.ReportReply.enum_types = {}
type_descriptors.ReportReply.fields = {
	field_descriptors.ReportReply_history,
	field_descriptors.ReportReply_tasks
}
type_descriptors.ReportReply.is_extendable = false
type_descriptors.ReportReply.extensions = {}
type_descriptors.TakeLvRewardReply.name = "TakeLvRewardReply"
type_descriptors.TakeLvRewardReply.full_name = ".TakeLvRewardReply"
type_descriptors.TakeLvRewardReply.nested_types = {}
type_descriptors.TakeLvRewardReply.enum_types = {}
type_descriptors.TakeLvRewardReply.fields = {}
type_descriptors.TakeLvRewardReply.is_extendable = false
type_descriptors.TakeLvRewardReply.extensions = {}
field_descriptors.SeasonSettle_id.name = "id"
field_descriptors.SeasonSettle_id.full_name = ".SeasonSettle.id"
field_descriptors.SeasonSettle_id.number = 1
field_descriptors.SeasonSettle_id.index = 0
field_descriptors.SeasonSettle_id.label = 1
field_descriptors.SeasonSettle_id.has_default_value = false
field_descriptors.SeasonSettle_id.default_value = 0
field_descriptors.SeasonSettle_id.type = 5
field_descriptors.SeasonSettle_id.cpp_type = 1
field_descriptors.SeasonSettle_lv.name = "lv"
field_descriptors.SeasonSettle_lv.full_name = ".SeasonSettle.lv"
field_descriptors.SeasonSettle_lv.number = 2
field_descriptors.SeasonSettle_lv.index = 1
field_descriptors.SeasonSettle_lv.label = 1
field_descriptors.SeasonSettle_lv.has_default_value = false
field_descriptors.SeasonSettle_lv.default_value = 0
field_descriptors.SeasonSettle_lv.type = 5
field_descriptors.SeasonSettle_lv.cpp_type = 1
field_descriptors.SeasonSettle_point.name = "point"
field_descriptors.SeasonSettle_point.full_name = ".SeasonSettle.point"
field_descriptors.SeasonSettle_point.number = 3
field_descriptors.SeasonSettle_point.index = 2
field_descriptors.SeasonSettle_point.label = 1
field_descriptors.SeasonSettle_point.has_default_value = false
field_descriptors.SeasonSettle_point.default_value = 0
field_descriptors.SeasonSettle_point.type = 5
field_descriptors.SeasonSettle_point.cpp_type = 1
field_descriptors.SeasonSettle_taskPoint.name = "taskPoint"
field_descriptors.SeasonSettle_taskPoint.full_name = ".SeasonSettle.taskPoint"
field_descriptors.SeasonSettle_taskPoint.number = 4
field_descriptors.SeasonSettle_taskPoint.index = 3
field_descriptors.SeasonSettle_taskPoint.label = 1
field_descriptors.SeasonSettle_taskPoint.has_default_value = false
field_descriptors.SeasonSettle_taskPoint.default_value = 0
field_descriptors.SeasonSettle_taskPoint.type = 5
field_descriptors.SeasonSettle_taskPoint.cpp_type = 1
type_descriptors.SeasonSettle.name = "SeasonSettle"
type_descriptors.SeasonSettle.full_name = ".SeasonSettle"
type_descriptors.SeasonSettle.nested_types = {}
type_descriptors.SeasonSettle.enum_types = {}
type_descriptors.SeasonSettle.fields = {
	field_descriptors.SeasonSettle_id,
	field_descriptors.SeasonSettle_lv,
	field_descriptors.SeasonSettle_point,
	field_descriptors.SeasonSettle_taskPoint
}
type_descriptors.SeasonSettle.is_extendable = false
type_descriptors.SeasonSettle.extensions = {}
type_descriptors.UpgradeReply.name = "UpgradeReply"
type_descriptors.UpgradeReply.full_name = ".UpgradeReply"
type_descriptors.UpgradeReply.nested_types = {}
type_descriptors.UpgradeReply.enum_types = {}
type_descriptors.UpgradeReply.fields = {}
type_descriptors.UpgradeReply.is_extendable = false
type_descriptors.UpgradeReply.extensions = {}
field_descriptors.SeasonInfoReply_id.name = "id"
field_descriptors.SeasonInfoReply_id.full_name = ".SeasonInfoReply.id"
field_descriptors.SeasonInfoReply_id.number = 1
field_descriptors.SeasonInfoReply_id.index = 0
field_descriptors.SeasonInfoReply_id.label = 1
field_descriptors.SeasonInfoReply_id.has_default_value = false
field_descriptors.SeasonInfoReply_id.default_value = 0
field_descriptors.SeasonInfoReply_id.type = 5
field_descriptors.SeasonInfoReply_id.cpp_type = 1
field_descriptors.SeasonInfoReply_lv.name = "lv"
field_descriptors.SeasonInfoReply_lv.full_name = ".SeasonInfoReply.lv"
field_descriptors.SeasonInfoReply_lv.number = 2
field_descriptors.SeasonInfoReply_lv.index = 1
field_descriptors.SeasonInfoReply_lv.label = 1
field_descriptors.SeasonInfoReply_lv.has_default_value = false
field_descriptors.SeasonInfoReply_lv.default_value = 0
field_descriptors.SeasonInfoReply_lv.type = 5
field_descriptors.SeasonInfoReply_lv.cpp_type = 1
field_descriptors.SeasonInfoReply_vip.name = "vip"
field_descriptors.SeasonInfoReply_vip.full_name = ".SeasonInfoReply.vip"
field_descriptors.SeasonInfoReply_vip.number = 3
field_descriptors.SeasonInfoReply_vip.index = 2
field_descriptors.SeasonInfoReply_vip.label = 1
field_descriptors.SeasonInfoReply_vip.has_default_value = false
field_descriptors.SeasonInfoReply_vip.default_value = 0
field_descriptors.SeasonInfoReply_vip.type = 5
field_descriptors.SeasonInfoReply_vip.cpp_type = 1
field_descriptors.SeasonInfoReply_point.name = "point"
field_descriptors.SeasonInfoReply_point.full_name = ".SeasonInfoReply.point"
field_descriptors.SeasonInfoReply_point.number = 4
field_descriptors.SeasonInfoReply_point.index = 3
field_descriptors.SeasonInfoReply_point.label = 1
field_descriptors.SeasonInfoReply_point.has_default_value = false
field_descriptors.SeasonInfoReply_point.default_value = 0
field_descriptors.SeasonInfoReply_point.type = 5
field_descriptors.SeasonInfoReply_point.cpp_type = 1
field_descriptors.SeasonInfoReply_today.name = "today"
field_descriptors.SeasonInfoReply_today.full_name = ".SeasonInfoReply.today"
field_descriptors.SeasonInfoReply_today.number = 5
field_descriptors.SeasonInfoReply_today.index = 4
field_descriptors.SeasonInfoReply_today.label = 1
field_descriptors.SeasonInfoReply_today.has_default_value = false
field_descriptors.SeasonInfoReply_today.default_value = 0
field_descriptors.SeasonInfoReply_today.type = 5
field_descriptors.SeasonInfoReply_today.cpp_type = 1
field_descriptors.SeasonInfoReply_lvs.name = "lvs"
field_descriptors.SeasonInfoReply_lvs.full_name = ".SeasonInfoReply.lvs"
field_descriptors.SeasonInfoReply_lvs.number = 6
field_descriptors.SeasonInfoReply_lvs.index = 5
field_descriptors.SeasonInfoReply_lvs.label = 3
field_descriptors.SeasonInfoReply_lvs.has_default_value = false
field_descriptors.SeasonInfoReply_lvs.default_value = {}
field_descriptors.SeasonInfoReply_lvs.type = 5
field_descriptors.SeasonInfoReply_lvs.cpp_type = 1
field_descriptors.SeasonInfoReply_vipLvs.name = "vipLvs"
field_descriptors.SeasonInfoReply_vipLvs.full_name = ".SeasonInfoReply.vipLvs"
field_descriptors.SeasonInfoReply_vipLvs.number = 7
field_descriptors.SeasonInfoReply_vipLvs.index = 6
field_descriptors.SeasonInfoReply_vipLvs.label = 3
field_descriptors.SeasonInfoReply_vipLvs.has_default_value = false
field_descriptors.SeasonInfoReply_vipLvs.default_value = {}
field_descriptors.SeasonInfoReply_vipLvs.type = 5
field_descriptors.SeasonInfoReply_vipLvs.cpp_type = 1
type_descriptors.SeasonInfoReply.name = "SeasonInfoReply"
type_descriptors.SeasonInfoReply.full_name = ".SeasonInfoReply"
type_descriptors.SeasonInfoReply.nested_types = {}
type_descriptors.SeasonInfoReply.enum_types = {}
type_descriptors.SeasonInfoReply.fields = {
	field_descriptors.SeasonInfoReply_id,
	field_descriptors.SeasonInfoReply_lv,
	field_descriptors.SeasonInfoReply_vip,
	field_descriptors.SeasonInfoReply_point,
	field_descriptors.SeasonInfoReply_today,
	field_descriptors.SeasonInfoReply_lvs,
	field_descriptors.SeasonInfoReply_vipLvs
}
type_descriptors.SeasonInfoReply.is_extendable = false
type_descriptors.SeasonInfoReply.extensions = {}
field_descriptors.ReceiveScheduleRewardRequest_ids.name = "ids"
field_descriptors.ReceiveScheduleRewardRequest_ids.full_name = ".ReceiveScheduleRewardRequest.ids"
field_descriptors.ReceiveScheduleRewardRequest_ids.number = 1
field_descriptors.ReceiveScheduleRewardRequest_ids.index = 0
field_descriptors.ReceiveScheduleRewardRequest_ids.label = 3
field_descriptors.ReceiveScheduleRewardRequest_ids.has_default_value = false
field_descriptors.ReceiveScheduleRewardRequest_ids.default_value = {}
field_descriptors.ReceiveScheduleRewardRequest_ids.type = 5
field_descriptors.ReceiveScheduleRewardRequest_ids.cpp_type = 1
type_descriptors.ReceiveScheduleRewardRequest.name = "ReceiveScheduleRewardRequest"
type_descriptors.ReceiveScheduleRewardRequest.full_name = ".ReceiveScheduleRewardRequest"
type_descriptors.ReceiveScheduleRewardRequest.nested_types = {}
type_descriptors.ReceiveScheduleRewardRequest.enum_types = {}
type_descriptors.ReceiveScheduleRewardRequest.fields = {
	field_descriptors.ReceiveScheduleRewardRequest_ids
}
type_descriptors.ReceiveScheduleRewardRequest.is_extendable = false
type_descriptors.ReceiveScheduleRewardRequest.extensions = {}
field_descriptors.CircleTaskNO_id.name = "id"
field_descriptors.CircleTaskNO_id.full_name = ".CircleTaskNO.id"
field_descriptors.CircleTaskNO_id.number = 1
field_descriptors.CircleTaskNO_id.index = 0
field_descriptors.CircleTaskNO_id.label = 1
field_descriptors.CircleTaskNO_id.has_default_value = false
field_descriptors.CircleTaskNO_id.default_value = 0
field_descriptors.CircleTaskNO_id.type = 5
field_descriptors.CircleTaskNO_id.cpp_type = 1
field_descriptors.CircleTaskNO_todayPoint.name = "todayPoint"
field_descriptors.CircleTaskNO_todayPoint.full_name = ".CircleTaskNO.todayPoint"
field_descriptors.CircleTaskNO_todayPoint.number = 2
field_descriptors.CircleTaskNO_todayPoint.index = 1
field_descriptors.CircleTaskNO_todayPoint.label = 1
field_descriptors.CircleTaskNO_todayPoint.has_default_value = false
field_descriptors.CircleTaskNO_todayPoint.default_value = 0
field_descriptors.CircleTaskNO_todayPoint.type = 5
field_descriptors.CircleTaskNO_todayPoint.cpp_type = 1
field_descriptors.CircleTaskNO_cumulativePoint.name = "cumulativePoint"
field_descriptors.CircleTaskNO_cumulativePoint.full_name = ".CircleTaskNO.cumulativePoint"
field_descriptors.CircleTaskNO_cumulativePoint.number = 3
field_descriptors.CircleTaskNO_cumulativePoint.index = 2
field_descriptors.CircleTaskNO_cumulativePoint.label = 1
field_descriptors.CircleTaskNO_cumulativePoint.has_default_value = false
field_descriptors.CircleTaskNO_cumulativePoint.default_value = 0
field_descriptors.CircleTaskNO_cumulativePoint.type = 5
field_descriptors.CircleTaskNO_cumulativePoint.cpp_type = 1
type_descriptors.CircleTaskNO.name = "CircleTaskNO"
type_descriptors.CircleTaskNO.full_name = ".CircleTaskNO"
type_descriptors.CircleTaskNO.nested_types = {}
type_descriptors.CircleTaskNO.enum_types = {}
type_descriptors.CircleTaskNO.fields = {
	field_descriptors.CircleTaskNO_id,
	field_descriptors.CircleTaskNO_todayPoint,
	field_descriptors.CircleTaskNO_cumulativePoint
}
type_descriptors.CircleTaskNO.is_extendable = false
type_descriptors.CircleTaskNO.extensions = {}
field_descriptors.TakeTaskPointRequest_ids.name = "ids"
field_descriptors.TakeTaskPointRequest_ids.full_name = ".TakeTaskPointRequest.ids"
field_descriptors.TakeTaskPointRequest_ids.number = 1
field_descriptors.TakeTaskPointRequest_ids.index = 0
field_descriptors.TakeTaskPointRequest_ids.label = 3
field_descriptors.TakeTaskPointRequest_ids.has_default_value = false
field_descriptors.TakeTaskPointRequest_ids.default_value = {}
field_descriptors.TakeTaskPointRequest_ids.type = 5
field_descriptors.TakeTaskPointRequest_ids.cpp_type = 1
type_descriptors.TakeTaskPointRequest.name = "TakeTaskPointRequest"
type_descriptors.TakeTaskPointRequest.full_name = ".TakeTaskPointRequest"
type_descriptors.TakeTaskPointRequest.nested_types = {}
type_descriptors.TakeTaskPointRequest.enum_types = {}
type_descriptors.TakeTaskPointRequest.fields = {
	field_descriptors.TakeTaskPointRequest_ids
}
type_descriptors.TakeTaskPointRequest.is_extendable = false
type_descriptors.TakeTaskPointRequest.extensions = {}
field_descriptors.PointPush_point.name = "point"
field_descriptors.PointPush_point.full_name = ".PointPush.point"
field_descriptors.PointPush_point.number = 1
field_descriptors.PointPush_point.index = 0
field_descriptors.PointPush_point.label = 1
field_descriptors.PointPush_point.has_default_value = false
field_descriptors.PointPush_point.default_value = 0
field_descriptors.PointPush_point.type = 5
field_descriptors.PointPush_point.cpp_type = 1
field_descriptors.PointPush_taskId.name = "taskId"
field_descriptors.PointPush_taskId.full_name = ".PointPush.taskId"
field_descriptors.PointPush_taskId.number = 2
field_descriptors.PointPush_taskId.index = 1
field_descriptors.PointPush_taskId.label = 1
field_descriptors.PointPush_taskId.has_default_value = false
field_descriptors.PointPush_taskId.default_value = 0
field_descriptors.PointPush_taskId.type = 5
field_descriptors.PointPush_taskId.cpp_type = 1
type_descriptors.PointPush.name = "PointPush"
type_descriptors.PointPush.full_name = ".PointPush"
type_descriptors.PointPush.nested_types = {}
type_descriptors.PointPush.enum_types = {}
type_descriptors.PointPush.fields = {
	field_descriptors.PointPush_point,
	field_descriptors.PointPush_taskId
}
type_descriptors.PointPush.is_extendable = false
type_descriptors.PointPush.extensions = {}
type_descriptors.SeasonListTaskRequest.name = "SeasonListTaskRequest"
type_descriptors.SeasonListTaskRequest.full_name = ".SeasonListTaskRequest"
type_descriptors.SeasonListTaskRequest.nested_types = {}
type_descriptors.SeasonListTaskRequest.enum_types = {}
type_descriptors.SeasonListTaskRequest.fields = {}
type_descriptors.SeasonListTaskRequest.is_extendable = false
type_descriptors.SeasonListTaskRequest.extensions = {}
field_descriptors.UnlockVipRequest_type.name = "type"
field_descriptors.UnlockVipRequest_type.full_name = ".UnlockVipRequest.type"
field_descriptors.UnlockVipRequest_type.number = 1
field_descriptors.UnlockVipRequest_type.index = 0
field_descriptors.UnlockVipRequest_type.label = 1
field_descriptors.UnlockVipRequest_type.has_default_value = false
field_descriptors.UnlockVipRequest_type.default_value = 0
field_descriptors.UnlockVipRequest_type.type = 5
field_descriptors.UnlockVipRequest_type.cpp_type = 1
type_descriptors.UnlockVipRequest.name = "UnlockVipRequest"
type_descriptors.UnlockVipRequest.full_name = ".UnlockVipRequest"
type_descriptors.UnlockVipRequest.nested_types = {}
type_descriptors.UnlockVipRequest.enum_types = {}
type_descriptors.UnlockVipRequest.fields = {
	field_descriptors.UnlockVipRequest_type
}
type_descriptors.UnlockVipRequest.is_extendable = false
type_descriptors.UnlockVipRequest.extensions = {}
CircleTaskNO = protobuf.Message(type_descriptors.CircleTaskNO)
PointPush = protobuf.Message(type_descriptors.PointPush)
ReceiveScheduleRewardReply = protobuf.Message(type_descriptors.ReceiveScheduleRewardReply)
ReceiveScheduleRewardRequest = protobuf.Message(type_descriptors.ReceiveScheduleRewardRequest)
ReportReply = protobuf.Message(type_descriptors.ReportReply)
ReportRequest = protobuf.Message(type_descriptors.ReportRequest)
SeasonInfoReply = protobuf.Message(type_descriptors.SeasonInfoReply)
SeasonInfoRequest = protobuf.Message(type_descriptors.SeasonInfoRequest)
SeasonListTaskReply = protobuf.Message(type_descriptors.SeasonListTaskReply)
SeasonListTaskRequest = protobuf.Message(type_descriptors.SeasonListTaskRequest)
SeasonSettle = protobuf.Message(type_descriptors.SeasonSettle)
TakeLvRewardReply = protobuf.Message(type_descriptors.TakeLvRewardReply)
TakeLvRewardRequest = protobuf.Message(type_descriptors.TakeLvRewardRequest)
TakeTaskPointReply = protobuf.Message(type_descriptors.TakeTaskPointReply)
TakeTaskPointRequest = protobuf.Message(type_descriptors.TakeTaskPointRequest)
UnlockVipReply = protobuf.Message(type_descriptors.UnlockVipReply)
UnlockVipRequest = protobuf.Message(type_descriptors.UnlockVipRequest)
UpgradeReply = protobuf.Message(type_descriptors.UpgradeReply)
UpgradeRequest = protobuf.Message(type_descriptors.UpgradeRequest)

return _G["logic.proto.SeasonExtension_pb"]
