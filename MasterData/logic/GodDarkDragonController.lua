-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/controller/GodDarkDragonController.lua

module("logic.extensions.goddesscollector.controller.GodDarkDragonController", package.seeall)

local GodDarkDragonController = class("GodDarkDragonController", BaseController)

function GodDarkDragonController:ctor()
	return
end

function GodDarkDragonController:onInit()
	self:onReset()
end

function GodDarkDragonController:onReset()
	self._tempStageId = nil
	self._tempBuffMsg = nil
	self._tempMainMsg = nil
end

function GodDarkDragonController:getBuffStageRootDay(activityId)
	local buffStages = GodDarkDragonConfig.instance:getBuffStageCfgByActId(activityId)
	local maxRootDay = #(buffStages or {})
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	local rootDay = day % maxRootDay

	if rootDay == 0 then
		rootDay = maxRootDay
	end

	return rootDay
end

function GodDarkDragonController:handlePM_GodDarkDragonInfoRes(msg)
	GodDarkDragonModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GodDarkDragonInfoRes)
end

function GodDarkDragonController:handlePM_NotifyGodDarkDragonBuffChallengeEndRes(msg)
	self._tempBuffMsg = GameUtil.pbToTable(msg)

	if msg.isWin == true and msg.waitConfirm then
		GodDarkDragonModel.instance:setWaitConfirm(msg.activityId, GameUtil.pbToTable(msg.waitConfirm))
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyGodDarkDragonBuffChallengeEndRes)
end

function GodDarkDragonController:sendPM_GodDarkDragonBuffConfirmReqByRechallenge(activityId, confirm)
	local waitConfim = GodDarkDragonModel.instance:getWaitConfirm(activityId)

	self._tempStageId = waitConfim.buffStageId

	self:sendPM_GodDarkDragonBuffConfirmReq(activityId, confirm)
end

function GodDarkDragonController:sendPM_GodDarkDragonBuffConfirmReq(activityId, confirm)
	self._confirm = confirm

	if confirm == true then
		GodDarkDragonModel.instance:addBuffInfoByWait(activityId)
	else
		GodDarkDragonModel.instance:clearWaitBuffInfo(activityId)
	end

	GodDarkDragonAgent.instance:sendPM_GodDarkDragonBuffConfirmReq(activityId, confirm)
end

function GodDarkDragonController:handlePM_GodDarkDragonBuffConfirmRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GodDarkDragonBuffConfirmRes, self._confirm, self._tempStageId)

	self._confirm = nil
	self._tempStageId = nil
end

function GodDarkDragonController:handlePM_NotifyGodDarkDragonMainChallengeEndRes(msg)
	self._tempMainMsg = GameUtil.pbToTable(msg)

	if msg.isWin == true then
		GodDarkDragonModel.instance:handlePassMainStage(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NotifyGodDarkDragonMainChallengeEndRes)
end

function GodDarkDragonController:handlePM_GodDarkDragonGainPrizeRes(msg)
	GodDarkDragonModel.instance:handleGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_GodDarkDragonGainPrizeRes)
end

function GodDarkDragonController:sendStartBuffFight(activityId, stageId, form_pb)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBuffBattleEnd, self, activityId))
	GodDarkDragonAgent.instance:sendPM_GodDarkDragonBuffChallengeReq(activityId, stageId, form_pb)
end

function GodDarkDragonController:_onBuffBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._tempBuffMsg and self._tempBuffMsg.isWin and GodDarkDragonModel.instance:getWaitConfirm(activityId) then
		local data = GodDarkDragonModel.instance:getWaitConfirm(activityId)
		local day = GodDarkDragonModel.instance:getTodayBuffConfigDay(activityId)

		UIStateManager.instance:push(ViewName.GodDarkDragonResultView, activityId, day, data.buffStageId, data.myLimitNum, data.enemyLimitNum)

		return true
	end

	return false
end

function GodDarkDragonController:sendStartMainFight(activityId, stageId, myLimit, enemyLimit, simpleForm, enemyForm)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onMainBattleEnd, self, activityId))
	GodDarkDragonAgent.instance:sendPM_GodDarkDragonMainChallengeReq(activityId, stageId, myLimit, enemyLimit, simpleForm, enemyForm)
end

function GodDarkDragonController:_onMainBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if self._tempMainMsg and self._tempMainMsg.isWin and GodDarkDragonModel.instance:getWaitConfirm(activityId) then
		local data = GodDarkDragonModel.instance:getWaitConfirm(activityId)
		local day = GodDarkDragonModel.instance:getTodayBuffConfigDay(activityId)

		UIStateManager.instance:push(ViewName.GodDarkDragonResultView, activityId, day, data.buffStageId, data.myLimitNum, data.enemyLimitNum)

		return true
	end

	return false
end

GodDarkDragonController.instance = GodDarkDragonController.New()

return GodDarkDragonController
