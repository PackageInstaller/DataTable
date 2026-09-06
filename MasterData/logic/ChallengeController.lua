-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/controller/ChallengeController.lua

module("logic.extensions.challenge.controller.ChallengeController", package.seeall)

local ChallengeController = class("ChallengeController", BaseController)

function ChallengeController:onInit()
	ChallengeController.super.onInit(self)
end

function ChallengeController:onReset()
	return
end

function ChallengeController:startFight(challengeId, branchId)
	local isEnough, moFangLevel, challengeName = self:isMoFangLvEnough(challengeId)

	if isEnough then
		ChallengeAgent.instance:sendPM_ChallengeFightTeamReq(challengeId, branchId, 0, "")
	else
		TipsFacade.instance:openLockTips(moFangLevel, GameEnum.MagicLockType.Challenge, challengeName)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end
end

function ChallengeController:getPrize(challengeId, changeSetId, packPetId, reqExtParams, func)
	ChallengeAgent.instance:sendPM_ChallengeGainPrizeReq(challengeId, changeSetId, packPetId, reqExtParams, func)
end

function ChallengeController:extOpt(challengeId, strategy, prizeReq, reqExtParams)
	reqExtParams = reqExtParams or ""

	ChallengeAgent.instance:sendPM_ChallengeExtOperationReq(challengeId, strategy, prizeReq, reqExtParams)
end

function ChallengeController:extTeamOpt(challengeId, branchId, strategy, reqExtParams, func)
	ChallengeAgent.instance:sendPM_ChallengeTeamExtOperationReq(challengeId, branchId, strategy, reqExtParams, func)
end

function ChallengeController:isMoFangLvEnough(challengeId)
	local cfg = ChallengeConfig.instance:getChallengeCfg(challengeId)
	local moFangLevel = MofangModel.instance:getCurLv()
	local isEnough = moFangLevel >= cfg.mofangLv

	return isEnough, cfg.mofangLv, cfg.name
end

ChallengeController.instance = ChallengeController.New()

return ChallengeController
