-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/controller/KunLunChallengeController.lua

module("logic.extensions.kunlunchallenge.controller.KunLunChallengeController", package.seeall)

local KunLunChallengeController = class("KunLunChallengeController", BaseController)

function KunLunChallengeController:ctor()
	return
end

function KunLunChallengeController:onInit()
	GlobalDispatcher:addListener("enterkunlunchallenge", self._enterKunLunChallenge, self)
end

function KunLunChallengeController:sendPM_KunLunCommonClgInfoReq(activityId)
	KunLunChallengeAgent.instance:sendPM_KunLunCommonClgInfoReq(activityId)
end

function KunLunChallengeController:handlePM_KunLunCommonClgInfoRes(msg)
	KunLunChallengeModel.instance:handlePM_KunLunCommonClgInfoRes(msg)
	self:_updateNormalClgTimesRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.KunLunCommonClgInfoRes)
end

function KunLunChallengeController:sendPM_KunLunCommonClgFightReq(activityId, form)
	KunLunChallengeAgent.instance:sendPM_KunLunCommonClgFightReq(activityId, form)
end

function KunLunChallengeController:handlePM_KunLunCommonClgFightRes(status, msg)
	if status == 0 then
		KunLunChallengeModel.instance:handlePM_KunLunCommonClgFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KunLunCommonClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KunLunChallengeController:handlePM_NotifyKunLunCommonClgFightEndRes(msg)
	KunLunChallengeModel.instance:handlePM_NotifyKunLunCommonClgFightEndRes(msg)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.KunLunChallengeNormal)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyKunLunCommonClgFightEndRes)
end

function KunLunChallengeController:sendPM_KunLunExtremeClgInfoReq(activityId)
	KunLunChallengeAgent.instance:sendPM_KunLunExtremeClgInfoReq(activityId)
end

function KunLunChallengeController:handlePM_KunLunExtremeClgInfoRes(msg)
	KunLunChallengeModel.instance:handlePM_KunLunExtremeClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KunLunExtremeClgInfoRes)
end

function KunLunChallengeController:sendPM_KunLunExtremeClgSetCardReq(activityId, stageId, cardIds)
	KunLunChallengeAgent.instance:sendPM_KunLunExtremeClgSetCardReq(activityId, stageId, cardIds)
end

function KunLunChallengeController:handlePM_KunLunExtremeClgSetCardRes(msg)
	KunLunChallengeModel.instance:handlePM_KunLunExtremeClgSetCardRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KunLunExtremeClgSetCardRes)
end

function KunLunChallengeController:sendPM_KunLunExtremeClgResetStageReq(activityId, stageId)
	KunLunChallengeAgent.instance:sendPM_KunLunExtremeClgResetStageReq(activityId, stageId)
end

function KunLunChallengeController:handlePM_KunLunExtremeClgResetStageRes(msg)
	KunLunChallengeModel.instance:handlePM_KunLunExtremeClgResetStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KunLunExtremeClgResetStageRes)
end

function KunLunChallengeController:sendPM_KunLunExtremeClgFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._handlerBattleEndInExt, self, activityId, stageId))
	KunLunChallengeAgent.instance:sendPM_KunLunExtremeClgFightReq(activityId, stageId, form)
end

function KunLunChallengeController:handlePM_KunLunExtremeClgFightRes(status, msg)
	if status == 0 then
		KunLunChallengeModel.instance:handlePM_KunLunExtremeClgFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KunLunExtremeClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KunLunChallengeController:handlePM_NotifyKunLunExtremeClgFightEndRes(msg)
	KunLunChallengeModel.instance:handlePM_NotifyKunLunExtremeClgFightEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyKunLunExtremeClgFightEndRes)
end

function KunLunChallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KunLunChallengeController:getActivityType()
	return GameEnum.ActivityType.KunLunChallenge
end

function KunLunChallengeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KunLunChallengeController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function KunLunChallengeController:getSkinId(activityId)
	return KunLunChallengeConfig.instance:getClientCommonValue(activityId, "KUNLUNCHALLENGE_PET_SKINID", true)
end

function KunLunChallengeController:_enterKunLunChallenge(params)
	self:enterKunLunChallenge(checknumber(params[1]))
end

function KunLunChallengeController:enterKunLunChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.KunLunChallengeMainView, activityId)
end

function KunLunChallengeController:enterBattleOfNorClg(activityId)
	local customFmtMo = KunLunChallengeModel.instance:getCustomFmtMoOfNorClg()

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KunLunChallengeController:enterBattleOfExtClg(activityId, stageId)
	local customFmtMo = KunLunChallengeModel.instance:getCustomFmtMoOfExtClg()

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KunLunChallengeController:_handlerBattleEndInExt(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = self:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	return false
end

function KunLunChallengeController:_updateNormalClgTimesRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_KUNLUNCHALLENGE_NORMAL_CLG_TIMES

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and self:isEnoughLeftFightCountOfNorClg(activityId) and not self:isPassOfNorClg() or nil) and true)
end

function KunLunChallengeController:isHasGainPrizeInProgressOfNorClg(activityId, prizeId)
	return self:isEnoughPrizeInProgressOfNorClg(activityId, prizeId)
end

function KunLunChallengeController:isEnoughPrizeInProgressOfNorClg(activityId, prizeId)
	local curHp = self:getBossLeftHpOfNorClg()
	local data = KunLunChallengeConfig.instance:getKlDamageData(activityId, prizeId)

	return curHp <= data.bossLeftHp
end

function KunLunChallengeController:getBossLeftHpOfNorClg()
	local hp = KunLunChallengeModel.instance:getBossLeftHpOfNorClg()

	return Mathf.Min(hp, 10000)
end

function KunLunChallengeController:getTryFightOfNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isEnoughLeftFightCountOfNorClg(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "次数用尽"
	elseif self:isPassOfNorClg() then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

function KunLunChallengeController:isPassOfNorClg()
	return self:getBossLeftHpOfNorClg() <= 0
end

function KunLunChallengeController:isEnoughLeftFightCountOfNorClg(activityId)
	local leftCount = self:getLeftDailyTimesOfNorClg(activityId)

	return leftCount > 0
end

function KunLunChallengeController:getLeftDailyTimesOfNorClg(activityId)
	local curTimes = self:getDailyTimesOfNorClg()
	local maxTimes = self:getMaxDailyTimesOfNorClg(activityId)

	return Mathf.Max(maxTimes - curTimes, 0)
end

function KunLunChallengeController:getDailyTimesOfNorClg()
	return KunLunChallengeModel.instance:getDailyTimesOfNorClg()
end

function KunLunChallengeController:getMaxDailyTimesOfNorClg(activityId)
	local data = KunLunChallengeConfig.instance:getKlActData(activityId)

	return (data or nil) and (data.dailyCommonTimes or 0)
end

function KunLunChallengeController:isLockRaceIdOfNorClg(raceId)
	local list = self:getLockRaceIdsOfNorClg()

	return table.indexof(list, raceId)
end

function KunLunChallengeController:getLockRaceIdsOfNorClg()
	return (KunLunChallengeModel.instance:getLockRaceIdsOfNorClg())
end

function KunLunChallengeController:getKunLunExtClgMo(activityId)
	return KunLunChallengeModel.instance:getKunLunExtClgMo(activityId)
end

KunLunChallengeController.instance = KunLunChallengeController.New()

return KunLunChallengeController
