-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/CynthiaChallengeAgent.lua

module("logic.extensions.cynthiachallenge.agent.CynthiaChallengeAgent", package.seeall)

local CynthiaChallengeAgent = class("CynthiaChallengeAgent", BaseAgent)

function CynthiaChallengeAgent:sendPM_CynthiaChallengeGetInfoReq(challengeId)
	local req = CynthiaChallengeExtension_pb.PM_CynthiaChallengeGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function CynthiaChallengeAgent:handlePM_CynthiaChallengeGetInfoRes(status, msg)
	if status == 0 then
		CynthiaController.instance:handleGetInfo(msg)
	end
end

function CynthiaChallengeAgent:sendPM_CynthiaChallengeFightReq(challengeId, stage)
	local req = CynthiaChallengeExtension_pb.PM_CynthiaChallengeFightReq()

	req.challengeId = challengeId
	req.stage = stage

	self:sendMsg(req)
end

function CynthiaChallengeAgent:handlePM_CynthiaChallengeFightRes(status, msg)
	if status == 0 then
		CynthiaController.instance:handleStartFight(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
		GlobalDispatcher:dispatch(GlobalNotify.PM_CynthiaEnterBattleError)
	end
end

function CynthiaChallengeAgent:sendPM_CynthiaChallengeSweepReq(challengeId)
	local req = CynthiaChallengeExtension_pb.PM_CynthiaChallengeSweepReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function CynthiaChallengeAgent:handlePM_CynthiaChallengeSweepRes(status, msg)
	if status == 0 then
		CynthiaController.instance:handleStartSweep(msg)
	end
end

function CynthiaChallengeAgent:sendPM_CynthiaChallengeUpgradeReq(challengeId)
	local req = CynthiaChallengeExtension_pb.PM_CynthiaChallengeUpgradeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function CynthiaChallengeAgent:handlePM_CynthiaChallengeUpgradeRes(status, msg)
	if status == 0 then
		CynthiaController.instance:handleUpBuff(msg)
	end
end

function CynthiaChallengeAgent:handlePM_CynthiaChallengeAfterFightRes(status, msg)
	if status == 0 then
		CynthiaController.instance:handleFinishFight(msg)
	end
end

CynthiaChallengeAgent.instance = CynthiaChallengeAgent.New()

return CynthiaChallengeAgent
