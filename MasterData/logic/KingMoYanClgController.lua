-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/controller/KingMoYanClgController.lua

module("logic.extensions.kingmoyanclg.controller.KingMoYanClgController", package.seeall)

local KingMoYanClgController = class("KingMoYanClgController", BaseController)

function KingMoYanClgController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterkingmoyanclgmainview", self._enterEventOpenView, self)
end

function KingMoYanClgController:onReset()
	return
end

function KingMoYanClgController:sendPM_KingMoYanClgInfoReq(activityId)
	KingMoYanClgAgent.instance:sendPM_KingMoYanClgInfoReq(activityId)
end

function KingMoYanClgController:handlePM_KingMoYanClgInfoRes(msg)
	local mo = self:getKingMoYanClgMo(msg.activityId)

	mo:handlePM_KingMoYanClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingMoYanClgInfoRes)
end

function KingMoYanClgController:sendPM_KingMoYanClgChallengeReq(activityId, stageId, form)
	self._tempStageId = stageId

	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getKingMoYanClgMo(activityId)
		local msg = mo:getEndResMsg()

		if msg.isWin then
			UIStateManager.instance:push(ViewName.KingMoYanClgResultPopView, activityId)

			result = true
		end

		return result
	end)
	KingMoYanClgAgent.instance:sendPM_KingMoYanClgChallengeReq(activityId, stageId, form)
end

function KingMoYanClgController:handlePM_KingMoYanClgChallengeRes(msg)
	return
end

function KingMoYanClgController:sendPM_KingMoYanClgConfirmReq(activityId, save)
	KingMoYanClgAgent.instance:sendPM_KingMoYanClgConfirmReq(activityId, save)
end

function KingMoYanClgController:handlePM_KingMoYanClgConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getKingMoYanClgMo(msg.activityId)

		mo:handlePM_KingMoYanClgConfirmRes(msg, self._tempStageId)

		if msg:HasField("changeSetId") then
			mo:setChangeSetId(msg.changeSetId)
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		end
	end

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if isAoqiGodProcessType then
		local mo = self:getKingMoYanClgMo(msg.activityId)

		if mo:isPassAll() then
			BattleController.instance:endBattle()

			local activityType = ActivityDefineController.instance:getActTypeByActId(msg.activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, msg.activityId)
		else
			GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingMoYanClgConfirmRes, status, msg)
		end
	else
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingMoYanClgConfirmRes, status, msg)
	end

	self._tempStageId = nil
end

function KingMoYanClgController:sendPM_KingMoYanClgResetReq(activityId)
	KingMoYanClgAgent.instance:sendPM_KingMoYanClgResetReq(activityId)
end

function KingMoYanClgController:handlePM_KingMoYanClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingMoYanClgResetRes)
end

function KingMoYanClgController:handlePM_NotifyKingMoYanClgFinishRes(msg)
	local mo = self:getKingMoYanClgMo(msg.activityId)

	mo:handlePM_NotifyKingMoYanClgFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyKingMoYanClgFinishRes)
end

function KingMoYanClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KingMoYanClgController:getActivityType()
	return GameEnum.ActivityType.KingMoYanClg
end

function KingMoYanClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KingMoYanClgController:getKingMoYanClgMo(activityId)
	return KingMoYanClgModel.instance:getKingMoYanClgMo(activityId)
end

function KingMoYanClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function KingMoYanClgController:getSkinId(activityId)
	local data = KingMoYanClgConfig.instance:getActData(activityId)

	return (data or nil) and (data.raceId or 0)
end

function KingMoYanClgController:enterBattle(activityId, stageId)
	local fmtMo = KingMoYanClgModel.instance:getKingMoYanClgFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function KingMoYanClgController:getTryStartClgResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self:getLongYanMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:isPassAll() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function KingMoYanClgController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.KingMoYanClgMainView, actId)
end

KingMoYanClgController.instance = KingMoYanClgController.New()

return KingMoYanClgController
