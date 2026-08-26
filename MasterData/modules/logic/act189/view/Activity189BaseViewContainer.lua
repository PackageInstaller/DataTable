-- chunkname: @modules/logic/act189/view/Activity189BaseViewContainer.lua

module("modules.logic.act189.view.Activity189BaseViewContainer", package.seeall)

local Activity189BaseViewContainer = class("Activity189BaseViewContainer", BaseViewContainer)

function Activity189BaseViewContainer:getActivityRemainTimeStr()
	return ActivityHelper.getActivityRemainTimeStr(self:actId())
end

function Activity189BaseViewContainer:sendGetTaskInfoRequest(callback, callbackObj)
	Activity189Controller.instance:sendGetTaskInfoRequest(callback, callbackObj)
end

function Activity189BaseViewContainer:sendFinishAllTaskRequest(callback, callbackObj)
	Activity189Controller.instance:sendFinishAllTaskRequest(self:actId(), callback, callbackObj)
end

function Activity189BaseViewContainer:sendFinishTaskRequest(taskId, callback, callbackObj)
	TaskRpc.instance:sendFinishTaskRequest(taskId, callback, callbackObj)
end

function Activity189BaseViewContainer:actId()
	assert(false, "please override this function")
end

return Activity189BaseViewContainer
