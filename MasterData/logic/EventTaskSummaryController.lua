-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/controller/EventTaskSummaryController.lua

module("logic.extensions.eventtasksummary.controller.EventTaskSummaryController", package.seeall)

local EventTaskSummaryController = class("EventTaskSummaryController", BaseController)

function EventTaskSummaryController:ctor()
	return
end

function EventTaskSummaryController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._ItemGetViewDoClosed, self)
	self:onReset()
end

function EventTaskSummaryController:onReset()
	self._needGotoWabao = false
end

function EventTaskSummaryController:onSendEventTaskSummaryGetInfoReq(activityId)
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(activityId)
end

function EventTaskSummaryController:onHandleEventTaskSummaryGetInfoRes(msg)
	EventTaskSummaryModel.instance:onHandleEventTaskSummaryGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, msg)
end

function EventTaskSummaryController:onSendEventTaskSummaryGainTaskPrizeReq(activityId, taskId)
	if taskId ~= nil and type(taskId) ~= "table" then
		taskId = {
			taskId
		}
	end

	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGainTaskPrizeReq(activityId, taskId)
end

function EventTaskSummaryController:onHandleEventTaskSummaryGainTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_FORMULATASKRES, msg)
end

function EventTaskSummaryController:onSendEventTaskSummaryViewReq(activityId, id)
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryViewReq(activityId, id)
end

function EventTaskSummaryController:dailyRefresh()
	return
end

function EventTaskSummaryController:getCurRedIdByActivityType(activityType)
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	return (actCfg or nil) and self:getCurRedIdByActivityId(actCfg.activityId)
end

function EventTaskSummaryController:getCurRedIdByActivityId(activityId)
	local planCfg = EventTaskSummaryConfig.instance:getPlanCfg(activityId)

	return (planCfg or nil) and (planCfg.redPointId or 0)
end

function EventTaskSummaryController:getActivityTypeByActivityId(activityId)
	local planCfg = EventTaskSummaryConfig.instance:getPlanCfg(activityId)

	return (planCfg or nil) and (planCfg.activityType or 0)
end

function EventTaskSummaryController:calcTaskState(activityId, taskId)
	local state = GameEnum.PrizeState.IsCanGet

	if self:isTaskHasGainPrize(taskId) then
		state = GameEnum.PrizeState.IsHasGain
	elseif not self:isTaskEnoughProgress(activityId, taskId) then
		state = GameEnum.PrizeState.IsNotEnough
	end

	return state
end

function EventTaskSummaryController:isTaskEnoughProgress(activityId, taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(activityId, taskId)
	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(taskId)

	return curProgress >= taskData.maxProgress
end

function EventTaskSummaryController:isTaskHasGainPrize(taskId)
	return EventTaskSummaryModel.instance:isTaskHasGainPrize(taskId)
end

function EventTaskSummaryController:isTaskInTime(activityId, taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(activityId, taskId)
	local timePeriod = GameUtil.getTimePeriod(taskData.startTime, taskData.endTime)

	return timePeriod == GameUtil.inTimePeriod
end

function EventTaskSummaryController:isTaskHasJumpStr(activityId, taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(activityId, taskId)

	return not string.nilorempty(taskData.jumpTo)
end

function EventTaskSummaryController:_ItemGetViewDoClosed()
	if self._needGotoWabao then
		self._needGotoWabao = false

		local _itemData = {
			id = 605,
			type = MatType.Item
		}

		TreasureNewController.instance:useTreasureMap(_itemData, 1)
	end
end

function EventTaskSummaryController:useItemInReadyforwarView(matId, useNum)
	MaterialFacade.instance:useItem(MatType.Item, matId, useNum, nil, function()
		self._needGotoWabao = true
	end)
end

EventTaskSummaryController.instance = EventTaskSummaryController.New()

return EventTaskSummaryController
