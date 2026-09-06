-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/CynthiaController.lua

module("logic.extensions.timelimitedchallenge.controller.CynthiaController", package.seeall)

local CynthiaController = class("CynthiaController", BaseController)

function CynthiaController:getInfo(challengeId)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeGetInfoReq(challengeId)
end

function CynthiaController:handleGetInfo(msg)
	CynthiaModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CynthiaGetInfoRes)
end

function CynthiaController:startFight(challengeId, stage)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeFightReq(challengeId, stage)
end

function CynthiaController:handleStartFight(msg)
	CynthiaModel.instance:onStartFight(msg)
end

function CynthiaController:upBuff(challengeId)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeUpgradeReq(challengeId)
end

function CynthiaController:handleUpBuff(msg)
	CynthiaModel.instance:onGetUpBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CynthiaBuffUpRes)
end

function CynthiaController:startSweep(challengeId)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeSweepReq(challengeId)
end

function CynthiaController:handleStartSweep(msg)
	CynthiaModel.instance:onStartSweep(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CynthiaGetInfoRes)
end

function CynthiaController:handleFinishFight(msg)
	CynthiaModel.instance:onFinishFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CynthiaGetInfoRes)
end

function CynthiaController:onBattleEnd(challengeId)
	UIStateManager.instance:push(ViewName.CynthiaresultView, challengeId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	return true
end

CynthiaController.instance = CynthiaController.New()

return CynthiaController
