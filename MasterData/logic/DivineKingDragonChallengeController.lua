-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/controller/DivineKingDragonChallengeController.lua

module("logic.extensions.divinekingdragonchallenge.controller.DivineKingDragonChallengeController", package.seeall)

local DivineKingDragonChallengeController = class("DivineKingDragonChallengeController", BaseController)

function DivineKingDragonChallengeController:ctor()
	return
end

function DivineKingDragonChallengeController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivinekingdragonchallengemainview", self._enterEventOpenView, self)
end

function DivineKingDragonChallengeController:onReset()
	return
end

function DivineKingDragonChallengeController:sendPM_DivineKingDragonGetInfoReq(actId)
	DivineKingDragonAgent.instance:sendPM_DivineKingDragonGetInfoReq(actId)
end

function DivineKingDragonChallengeController:handlePM_DivineKingDragonGetInfoRes(msg)
	DivineKingDragonChallengeModel.instance:handlePM_DivineKingDragonGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonGetInfoRes)
end

function DivineKingDragonChallengeController:sendPM_DivineKingDragonChallengeReq(actId, stageId, teamId, form)
	DivineKingDragonAgent.instance:sendPM_DivineKingDragonChallengeReq(actId, stageId, teamId, form)
end

function DivineKingDragonChallengeController:handlePM_DivineKingDragonChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonChallengeRes, status)
end

function DivineKingDragonChallengeController:sendPM_DivineKingDragonGainPrizeReq(actId, stageId)
	DivineKingDragonAgent.instance:sendPM_DivineKingDragonGainPrizeReq(actId, stageId)
end

function DivineKingDragonChallengeController:handlePM_DivineKingDragonGainPrizeRes(msg)
	DivineKingDragonChallengeModel.instance:handlePM_DivineKingDragonGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonGainPrizeRes)
end

function DivineKingDragonChallengeController:sendPM_DivineKingDragonResetReq(actId, stageId, teamId)
	DivineKingDragonAgent.instance:sendPM_DivineKingDragonResetReq(actId, stageId, teamId)
end

function DivineKingDragonChallengeController:handlePM_DivineKingDragonResetRes(msg)
	DivineKingDragonChallengeModel.instance:handlePM_DivineKingDragonResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonResetRes)
end

function DivineKingDragonChallengeController:handlePM_DivineKingDragonNotifyChallengeRes(msg)
	DivineKingDragonChallengeModel.instance:handlePM_DivineKingDragonNotifyChallengeRes(msg)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.actId)

	if isAoqiGodProcessType then
		local pass = self:hasPassChallenge(msg.actId)

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineKingDragonChallenge, msg.actId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineKingDragonNotifyChallengeRes)
end

function DivineKingDragonChallengeController:getActivityId()
	return 314001
end

function DivineKingDragonChallengeController:getActivityType()
	return GameEnum.ActivityType.DivineKingDragonChallenge
end

function DivineKingDragonChallengeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineKingDragonChallengeController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DivineKingDragonChallengeController:getSkinId(activityId)
	return DivineKingDragonChallengeConfig.instance:getDkdCommonValue(activityId, "skinId")
end

function DivineKingDragonChallengeController:enterBattleOfNorClg(activityId, stageId, teamId)
	local customFmtMo = DivineKingDragonChallengeModel.instance:getCustomFmtMoOfGkd()

	customFmtMo:updateCfg(activityId, stageId, teamId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineKingDragonChallengeController:getDivineKingDragonMo(activityId)
	return DivineKingDragonChallengeModel.instance:_getDivineKingDragonMo(activityId)
end

function DivineKingDragonChallengeController:hasPassChallenge(activityId)
	local mo = self:getDivineKingDragonMo(activityId)
	local stageCfgs = DivineKingDragonChallengeConfig.instance:getDkdStageDataList(activityId)

	for i, cfg in ipairs(stageCfgs) do
		local stageId = cfg.stageId
		local teamPlanId = cfg.teamPlanId
		local teamCfgs = DivineKingDragonChallengeConfig.instance:getDkdTeamDataList(teamPlanId)

		for i, teamCfg in ipairs(teamCfgs) do
			local teamId = teamCfg.teamId
			local isPass = mo:isPassOfTeam(stageId, teamId)

			if not isPass then
				return false
			end
		end
	end

	return true
end

function DivineKingDragonChallengeController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.DivineKingDragonChallengeMainView, actId)
end

DivineKingDragonChallengeController.instance = DivineKingDragonChallengeController.New()

return DivineKingDragonChallengeController
