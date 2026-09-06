-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/controller/DualTrialController.lua

module("logic.extensions.dualtrial.controller.DualTrialController", package.seeall)

local DualTrialController = class("DualTrialController", BaseController)

function DualTrialController:ctor()
	return
end

function DualTrialController:onInit()
	self:onReset()
end

function DualTrialController:onReset()
	self._fmtMo = DualTrialFmtMo.New()
end

function DualTrialController:openMissionView(activityId, creepsMasterId)
	self._fmtMo:initParams(activityId, creepsMasterId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function DualTrialController:getInfo(activityId)
	DualTrialAgent.instance:sendPM_DualTrialGetInfoReq(activityId)
end

function DualTrialController:handleGetInfo(msg)
	DualTrialModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DualTrialGetInfo)
end

function DualTrialController:beginEvent(activityId)
	DualTrialAgent.instance:sendPM_DualTrialBeginEventReq(activityId)
end

function DualTrialController:handleBeginEvent(msg)
	DualTrialModel.instance:onBeginEvent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DualTrialBeginEvent)
end

function DualTrialController:endEvent(activityId)
	DualTrialAgent.instance:sendPM_DualTrialEndEventReq(activityId)
end

function DualTrialController:handleEndEvent(msg)
	DualTrialModel.instance:onEndEvent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DualTrialEndEvent)
end

function DualTrialController:visitBlock(activityId)
	DualTrialAgent.instance:sendPM_DualTrialVisitBlockReq(activityId)
end

function DualTrialController:handleVisitBlock(msg)
	DualTrialModel.instance:onVisitBlock(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DualTrialVisitBlock)
end

function DualTrialController:fight(activityId, form)
	DualTrialAgent.instance:sendPM_DualTrialFightReq(activityId, form)
end

function DualTrialController:handleNotifyFightRes(msg)
	DualTrialModel.instance:onNotifyFight(msg)
end

function DualTrialController:gainPrize(activityId, prizeId)
	DualTrialAgent.instance:sendPM_DualTrialGainPrizeReq(activityId, prizeId)
end

function DualTrialController:handleGainPrize(msg)
	DualTrialModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DualTrialGainPrize)
end

function DualTrialController:onepEventView(activityId, isPlayAni)
	local info = DualTrialModel.instance:getInfoByActId(activityId)
	local curEvent = info and info.event

	if curEvent then
		if isPlayAni then
			UIStateManager.instance:push(ViewName.DualTrialPatrolView, activityId)

			return
		end

		local curBlockId = checknumber(info.curBlockId)
		local eventId = curEvent.eventId
		local curBlockCfg = DualTrialConfig.instance:getBlockCfg(activityId, curBlockId)
		local eventCfg = DualTrialConfig.instance:getEventCfg(curBlockCfg.eventPlanId, eventId)
		local eventType = eventCfg and eventCfg.eventType

		if eventType == 1 then
			UIStateManager.instance:push(ViewName.DualTrialAfkView, activityId, eventCfg)
		elseif eventType == 2 then
			UIStateManager.instance:push(ViewName.DualTrialFightView, activityId, eventCfg)
		elseif eventType == 3 then
			UIStateManager.instance:push(ViewName.DualTrialDialogueView, activityId, eventCfg)
		else
			printError("事件类型未定义")
		end
	else
		UIStateManager.instance:popByName(ViewName.DualTrialVisitView)
		UIStateManager.instance:push(ViewName.DualTrialMainView, activityId)
	end
end

DualTrialController.instance = DualTrialController.New()

return DualTrialController
