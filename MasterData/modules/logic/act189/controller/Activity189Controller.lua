-- chunkname: @modules/logic/act189/controller/Activity189Controller.lua

module("modules.logic.act189.controller.Activity189Controller", package.seeall)

local Activity189Controller = class("Activity189Controller", BaseController)

function Activity189Controller.dispatchEventUpdateActTag(activityId)
	local beginnerRedDot = ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)
	local beginnerParentReddot = RedDotConfig.instance:getParentRedDotId(beginnerRedDot)
	local tabRedDot = ActivityConfig.instance:getActivityRedDotId(activityId)

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(beginnerParentReddot)] = true,
		[tonumber(tabRedDot)] = true
	})
end

function Activity189Controller:onInit()
	self:reInit()
end

function Activity189Controller:reInit()
	return
end

function Activity189Controller:sendGetTaskInfoRequest(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		Activity189Config.instance:getTaskType()
	}, callback, callbackObj)
end

function Activity189Controller:sendFinishAllTaskRequest(activityId, callback, callbackObj)
	TaskRpc.instance:sendFinishAllTaskRequest(Activity189Config.instance:getTaskType(), nil, nil, callback, callbackObj, activityId)
end

function Activity189Controller:sendGetAct189OnceBonusRequest(activityId)
	return Activity189Rpc.instance:sendGetAct189OnceBonusRequest(activityId, Activity189Controller.dispatchEventUpdateActTag, activityId)
end

function Activity189Controller:sendGetAct189InfoRequest(activityId, cb, cbObj)
	return Activity189Rpc.instance:sendGetAct189InfoRequest(activityId, cb, cbObj)
end

function Activity189Controller:sendFinishReadTaskRequest(taskId)
	if not taskId or taskId == 0 then
		return
	end

	local taskCO = Activity189Config.instance:getTaskCO(taskId)

	if not taskCO then
		return
	end

	local activityId = taskCO.activityId

	TaskRpc.instance:sendFinishReadTaskRequest(taskId, Activity189Controller.dispatchEventUpdateActTag, activityId)
end

local kListenerType_ReadTask = "ReadTask"

function Activity189Controller:trySendFinishReadTaskRequest_jump(taskId)
	local taskCO = Activity189Config.instance:getTaskCO(taskId)

	if not taskCO then
		return
	end

	if taskCO.listenerType ~= kListenerType_ReadTask then
		return
	end

	self:sendFinishReadTaskRequest(taskId)
end

function Activity189Controller:checkRed_Task()
	local reddotid = RedDotEnum.DotNode.Activity189Task

	return RedDotModel.instance:isDotShow(reddotid, 0)
end

function Activity189Controller:checkActRed(activityId)
	if ActivityBeginnerController.instance:checkRedDot(activityId) then
		return true
	end

	return self:checkRed_Task()
end

Activity189Controller.instance = Activity189Controller.New()

return Activity189Controller
