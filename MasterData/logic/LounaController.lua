-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/LounaController.lua

module("logic.extensions.timelimitedchallenge.controller.LounaController", package.seeall)

local LounaController = class("LounaController", BaseController)

function LounaController:ctor()
	LounaController.super.ctor(self)
end

function LounaController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.ON_LOUNA_FIGHT_END, self.onGetFighMsg, self)
end

function LounaController:onReset()
	self.lounaFmtMo = LounaFmtMo.New()
end

function LounaController:getActivityId()
	return 183001
end

function LounaController:onGetFighMsg(msg)
	LounaModel.instance:onGetFighMsg(msg)
end

function LounaController:sendGetInfo(activityId)
	QingGuChallengeAgent.instance:sendPM_QingGuChallengeGetInfoReq(activityId)
end

function LounaController:onGetInfo(msg)
	LounaModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_LOUNA_INFO_UPDATE)
end

function LounaController:sendGetPrize(activityId, prizeId)
	QingGuChallengeAgent.instance:sendPM_QingGuChallengeGainPrizeReq(activityId, prizeId)
end

function LounaController:onGetPrize(msg)
	LounaModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_LOUNA_INFO_UPDATE)
end

function LounaController:sendStartFight(activityId, creepsMasterId, simpleForm)
	UIJumper.instance:pushOneStack(ViewName.LounachallengeView, true)
	UIJumper.instance:pushOneStack(ViewName.LounalevelsView, true)
	QingGuChallengeAgent.instance:sendPM_QingGuChallengeReq(activityId, creepsMasterId, simpleForm)
end

function LounaController:onFight(msg)
	return
end

function LounaController:openMissionView(activityId, data)
	local params = {}

	params.activityId = activityId
	params.creepsMasterId = data.creepsMasterId

	self.lounaFmtMo:initParams(params)
	CustomFmtController.instance:showMissionView(self.lounaFmtMo)
end

function LounaController:showResetView(activityId)
	if not LounaModel.instance.passedCreepsMasterIds then
		local passedCreepsMasterIds = {}
		local hasPlay = #passedCreepsMasterIds > 0

		if not hasPlay then
			TipsFacade.instance:openCommonTips(lang("无需重置"))

			return
		end

		local curTier = LounaModel.instance.curTier
		local cfg = LounaConfig.instance:getChallengeCfgById(activityId) or {}
		local tierPlanId = cfg.tierPlanId
		local tierCfg = LounaConfig.instance:getTierCfgById(tierPlanId, curTier) or {}
		local rulePlanId = tierCfg.rulePlanId
		local rulecfg = LounaConfig.instance:getRuleCfg(rulePlanId) or {}

		TipsFacade.instance:openPopupWindow(lang("tip"), rulecfg.resetDesc, function()
			QingGuChallengeAgent.instance:sendPM_QingGuChallengeResetReq(activityId)
		end)
	end
end

function LounaController:onResetChallenge(msg)
	LounaModel.instance:onResetChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ON_LOUNA_INFO_UPDATE)
end

function LounaController:getPetHpRatioAsUnit(petMo)
	return LounaModel.instance:getPetHp(petMo)
end

function LounaController:checkIsLimit(petMo)
	if petMo then
		local ruleHandler, cfg = self:getCurRuleType()

		if ruleHandler == "DiePet" then
			return LounaModel.instance:getPetHp(petMo) <= 0
		elseif ruleHandler == "Formation" then
			return LounaModel.instance:getPetTimes(petMo) >= checknumber((cfg.ruleParams or {}).times)
		end
	end

	return false
end

function LounaController:getCurRuleType()
	local curTier = LounaModel.instance.curTier
	local cfg = LounaConfig.instance:getChallengeCfgById(self:getActivityId()) or {}
	local tierPlanId = checknumber(cfg.tierPlanId)
	local tierCfg = LounaConfig.instance:getTierCfgById(tierPlanId, curTier) or {}
	local rulePlanId = tierCfg.rulePlanId
	local rulecfg = LounaConfig.instance:getRuleCfg(rulePlanId) or {}
	local ruleHandler = rulecfg.ruleHandler

	return ruleHandler, rulecfg
end

LounaController.instance = LounaController.New()

return LounaController
