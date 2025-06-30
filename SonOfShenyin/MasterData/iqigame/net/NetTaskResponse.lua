-- chunkname: @IQIGame\\Net\\NetTaskResponse.lua

function net_task.submitResult(code, cids, shows)
	TaskSystemModule.SubmitResultSucceed(code, cids, shows)
end

function net_task.submitTypeResult(code, shows)
	TaskSystemModule.SubmitResultForTypeSucceed(code, shows)
end

function net_task.notifyTask(tasks)
	TaskSystemModule.NotifyTask(tasks)
end

function net_task.notifyRemove(toRemoveTaskCIDs)
	TaskSystemModule.NotifyRemove(toRemoveTaskCIDs)
end

function net_task.notifyRemoveFinish(tasks)
	TaskSystemModule.NotifyRemoveFinish(tasks)
end

function net_task.notifyFinish(tasks)
	TaskSystemModule.NotifyFinish(tasks)
end

function net_task.notifyRemoveTaskCompleteTime(tasks)
	TaskSystemModule.NotifyRemoveTaskCompleteTime(tasks)
end

function net_task.obtainTaskResult(code)
	TaskSystemModule.ObtainTaskResult()
end

function net_task.repairTaskResult(code)
	return
end

function net_task.trackTaskResult(code)
	EventDispatcher.Dispatch(EventID.TrackTaskResultEvent)
end
