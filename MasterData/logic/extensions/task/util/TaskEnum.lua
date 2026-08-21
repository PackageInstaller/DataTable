-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/TaskEnum.lua

module("logic.extensions.task.util.TaskEnum", package.seeall)

Const = {
	Any = 0
}
TaskType = {
	Begin = 1,
	Daily = 2,
	Limited = 5,
	RogueWeekly = 11,
	RogueMonthly = 12,
	Challenge = 4,
	RogueFixed = 13,
	Weekly = 3
}
BubbleFactor = {
	GetAllPointReward = 1,
	NoAction = 4,
	GetPoint = 3,
	GetPointReward = 2
}
TaskState = {
	Finish = 3,
	Doing = 1,
	CanReceive = 2
}
TaskLabel = TaskExtension_pb.TaskLabel
