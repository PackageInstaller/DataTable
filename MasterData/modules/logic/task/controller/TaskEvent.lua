-- chunkname: @modules/logic/task/controller/TaskEvent.lua

module("modules.logic.task.controller.TaskEvent", package.seeall)

local TaskEvent = _M

TaskEvent.SuccessGetBonus = 1001
TaskEvent.UpdateTaskList = 1002
TaskEvent.SetTaskList = 1003
TaskEvent.OnFinishTask = 1004
TaskEvent.RefreshActState = 1005
TaskEvent.GetAllTaskReward = 1006
TaskEvent.GetTaskReward = 1007
TaskEvent.OnDeleteTask = 1008
TaskEvent.onReceiveFinishReadTaskReply = 1009
TaskEvent.OnShowTaskFinished = 1100
TaskEvent.OnRefreshActItem = 1101
TaskEvent.OnClickFinishAllTask = 1201

return TaskEvent
