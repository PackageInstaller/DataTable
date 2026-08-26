-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/TaskViewBaseContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.TaskViewBaseContainer", package.seeall)

local TaskViewBaseContainer = class("TaskViewBaseContainer", BaseViewContainer)

function TaskViewBaseContainer:sendGetTaskInfoRequest(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		self:taskType()
	}, callback, callbackObj)
end

function TaskViewBaseContainer:sendFinishAllTaskRequest(callback, callbackObj)
	TaskRpc.instance:sendFinishAllTaskRequest(self:taskType(), nil, nil, callback, callbackObj, self:actId())
end

function TaskViewBaseContainer:sendFinishTaskRequest(taskId, callback, callbackObj)
	TaskRpc.instance:sendFinishTaskRequest(taskId, callback, callbackObj)
end

function TaskViewBaseContainer:getActivityRemainTimeStr()
	return ActivityHelper.getActivityRemainTimeStr(self:actId())
end

function TaskViewBaseContainer:startBlock(timeout, key)
	UIBlockHelper.instance:startBlock(key or self.viewName, timeout or 3)
end

function TaskViewBaseContainer:endBlock(key)
	UIBlockHelper.instance:endBlock(key or self.viewName)
end

function TaskViewBaseContainer:startBlockSlient(timeout, key)
	UIBlockMgrExtend.setNeedCircleMv(false)
	self:startBlock(timeout, key)
end

function TaskViewBaseContainer:endBlockSlient(key)
	self:endBlock(key)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function TaskViewBaseContainer:simpleLockScreen(bLock)
	if bLock then
		self:startBlockSlient()
	else
		self:endBlockSlient()
	end
end

function TaskViewBaseContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function TaskViewBaseContainer:actId()
	assert(false, "please override this function")
end

function TaskViewBaseContainer:taskType()
	assert(false, "please override this function")
end

return TaskViewBaseContainer
