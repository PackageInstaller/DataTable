-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/controller/CorPrChallengeController.lua

module("logic.extensions.corpr.controller.CorPrChallengeController", package.seeall)

local CorPrChallengeController = class("CorPrChallengeController", BaseController)

function CorPrChallengeController:ctor()
	return
end

function CorPrChallengeController:onInit()
	self:onReset()
end

function CorPrChallengeController:onReset()
	return
end

function CorPrChallengeController:sendPM_CorrectPrincipleChallengeGetInfoReq(challengeId)
	CorrectPrincipleChallengeAgent.instance:sendPM_CorrectPrincipleChallengeGetInfoReq(challengeId)
end

function CorPrChallengeController:handlePM_CorrectPrincipleChallengeGetInfoRes(msg)
	CorPrChallengeModel.instance:handlePM_CorrectPrincipleChallengeGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CorPrChallengeGetInfoRes)
end

function CorPrChallengeController:sendPM_CorrectPrincipleChallengeFightReq(challengeId, simpleForm)
	CorrectPrincipleChallengeAgent.instance:sendPM_CorrectPrincipleChallengeFightReq(challengeId, simpleForm)
end

function CorPrChallengeController:handlePM_CorrectPrincipleChallengeFightRes(msg)
	CorPrChallengeModel.instance:handlePM_CorrectPrincipleChallengeFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CorPrChallengeFightRes)
end

function CorPrChallengeController:handlePM_CorrectPrincipleChallengeNotifyFightEndRes(msg)
	CorPrChallengeModel.instance:handlePM_CorrectPrincipleChallengeNotifyFightEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CorPrChallengeNotifyFightEndRes)
end

function CorPrChallengeController:enterBattleAsCorPr(challengeId, identityId, stageId)
	local customFmtMo = CorPrChallengeModel.instance:getCustomFmtMoAsCorPr()

	customFmtMo:updateCfg(challengeId, identityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function CorPrChallengeController:getStageCount(identityId)
	local cfg = CorPrChallengeConfig.instance:getcpMonsterCfg(identityId)

	return (cfg or nil) and (#cfg or 0)
end

function CorPrChallengeController:getCurChallengeIdentityId(challengeId)
	local identityId = 0
	local cfg = CorPrChallengeConfig.instance:getCpIdentityCfg(challengeId)

	for _, data in ipairs(cfg) do
		if self:isUnlockAsIdentity(challengeId, data.identityId) and not self:isPassAsIdentity(data.identityId) then
			identityId = data.identityId

			break
		end
	end

	return identityId
end

function CorPrChallengeController:getTryEnteryIdentityResultAndTips(challengeId, identityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInTimeAsIdentity(challengeId, identityId) then
		result = GameEnum.ResultCode.NotInTime

		local data = CorPrChallengeConfig.instance:getCpIdentityData(challengeId, identityId)

		if data.openTime then
			local date = GameUtil.string2date(data.openTime)

			tips = string.format("%s年%s月%s号%02d:%02d 开启", date.year, date.month, date.day, date.hour, date.min)
		end
	elseif not self:isPassLastAsIdentity(identityId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "解锁前置身份后开启"
	elseif self:isPassAsIdentity(identityId) then
		result = GameEnum.ResultCode.IsPass
		tips = "您已通关"
	end

	return result, tips
end

function CorPrChallengeController:isUnlockAsIdentity(challengeId, identityId)
	local result, tips = self:getTryEnteryIdentityResultAndTips(challengeId, identityId)

	return result == GameEnum.ResultCode.Success
end

function CorPrChallengeController:isPassLastAsIdentity(identityId)
	local lastIdentityId = Mathf.Max(identityId - 1, 0)

	return self:isPassAsIdentity(lastIdentityId)
end

function CorPrChallengeController:isPassAsIdentity(identityId)
	local maxStageId = self:getStageCount(identityId)

	return self:isPassAsStage(identityId, maxStageId)
end

function CorPrChallengeController:isInTimeAsIdentity(challengeId, identityId)
	local timePeriod = self:getTimePeriodAsIdentity(challengeId, identityId)

	return timePeriod == GameUtil.inTimePeriod
end

function CorPrChallengeController:getTimePeriodAsIdentity(challengeId, identityId)
	local data = CorPrChallengeConfig.instance:getCpIdentityData(challengeId, identityId)

	return GameUtil.getTimePeriod(data.openTime, nil)
end

function CorPrChallengeController:getTryChallengeStageResultAndTips(challengeId, identityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isUnlockAsStage(identityId, stageId) then
		result = GameEnum.ResultCode.NotUnlock
		tips = "请通过前面的关卡"
	elseif self:isPassAsStage(identityId, stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "您已通关"
	end

	return result, tips
end

function CorPrChallengeController:isUnlockAsStage(identityId, stageId)
	local lastStageId = Mathf.Max(stageId - 1, 0)

	return self:isPassAsStage(identityId, lastStageId)
end

function CorPrChallengeController:isPassAsStage(identityId, stageId)
	local stageInfo = CorPrChallengeModel.instance:getStageInfo()

	return (stageInfo or nil) and (identityId < stageInfo.identity and true or (identityId <= stageInfo.identity or false) and stageId < stageInfo.stageId)
end

CorPrChallengeController.instance = CorPrChallengeController.New()

return CorPrChallengeController
