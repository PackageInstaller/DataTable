-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/agent/CorrectPrincipleChallengeAgent.lua

module("logic.extensions.corpr.agent.CorrectPrincipleChallengeAgent", package.seeall)

local CorrectPrincipleChallengeAgent = class("CorrectPrincipleChallengeAgent", BaseAgent)

function CorrectPrincipleChallengeAgent:sendPM_CorrectPrincipleChallengeGetInfoReq(challengeId)
	local req = CorrectPrincipleChallengeExtension_pb.PM_CorrectPrincipleChallengeGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function CorrectPrincipleChallengeAgent:handlePM_CorrectPrincipleChallengeGetInfoRes(status, msg)
	if status == 0 then
		CorPrChallengeController.instance:handlePM_CorrectPrincipleChallengeGetInfoRes(msg)
	end
end

function CorrectPrincipleChallengeAgent:sendPM_CorrectPrincipleChallengeFightReq(challengeId, simpleForm)
	local req = CorrectPrincipleChallengeExtension_pb.PM_CorrectPrincipleChallengeFightReq()

	req.challengeId = challengeId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function CorrectPrincipleChallengeAgent:handlePM_CorrectPrincipleChallengeFightRes(status, msg)
	if status == 0 then
		CorPrChallengeController.instance:handlePM_CorrectPrincipleChallengeFightRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function CorrectPrincipleChallengeAgent:handlePM_CorrectPrincipleChallengeNotifyFightEndRes(status, msg)
	if status == 0 then
		CorPrChallengeController.instance:handlePM_CorrectPrincipleChallengeNotifyFightEndRes(msg)
	end
end

CorrectPrincipleChallengeAgent.instance = CorrectPrincipleChallengeAgent.New()

return CorrectPrincipleChallengeAgent
