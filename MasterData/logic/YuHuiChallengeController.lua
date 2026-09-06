-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/controller/YuHuiChallengeController.lua

module("logic.extensions.yuhuichallenge.controller.YuHuiChallengeController", package.seeall)

local YuHuiChallengeController = class("YuHuiChallengeController", BaseController)

function YuHuiChallengeController:ctor()
	return
end

function YuHuiChallengeController:getInfo(challengeId)
	YuHuiChallengeAgent.instance:sendPM_YuHuiChallengeGetInfoReq(challengeId)
end

function YuHuiChallengeController:handleGetInfo(msg)
	YuHuiChallengeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeGetInfo)
end

function YuHuiChallengeController:challengeFight(challengeId, modeId, fmo)
	local simpleForm = fmo:createFormPb()

	YuHuiChallengeAgent.instance:sendPM_YuHuiChallengeFightReq(challengeId, modeId, simpleForm)
end

function YuHuiChallengeController:handleChallengeFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeFight)
end

function YuHuiChallengeController:challengeReset(challengeId)
	YuHuiChallengeAgent.instance:sendPM_YuHuiChallengeResetReq(challengeId)
end

function YuHuiChallengeController:handleChallengeReset(msg)
	YuHuiChallengeModel.instance:onChallengeReset(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeReset)
end

function YuHuiChallengeController:handleChallengeFightEnd(msg)
	YuHuiChallengeModel.instance:onChallengeFightEnd(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeFightEnd)
end

function YuHuiChallengeController:sendSignBuff(challengeId)
	YuHuiChallengeAgent.instance:sendPM_YuHuiChallengeUpgradeSignInBuffReq(challengeId)
end

function YuHuiChallengeController:onSignBuff(msg)
	YuHuiChallengeModel.instance:onSignBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeGetInfo)
end

YuHuiChallengeController.instance = YuHuiChallengeController.New()

return YuHuiChallengeController
