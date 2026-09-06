-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/agent/YuHuiChallengeAgent.lua

module("logic.extensions.yuhuichallenge.agent.YuHuiChallengeAgent", package.seeall)

local YuHuiChallengeAgent = class("YuHuiChallengeAgent", BaseAgent)

function YuHuiChallengeAgent:sendPM_YuHuiChallengeGetInfoReq(challengeId)
	local req = YuHuiChallengeExtension_pb.PM_YuHuiChallengeGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YuHuiChallengeAgent:handlePM_YuHuiChallengeGetInfoRes(status, msg)
	if status == 0 then
		YuHuiChallengeController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeError, status)
	end
end

function YuHuiChallengeAgent:sendPM_YuHuiChallengeFightReq(challengeId, modeId, form)
	local req = YuHuiChallengeExtension_pb.PM_YuHuiChallengeFightReq()

	req.challengeId = challengeId
	req.modeId = modeId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function YuHuiChallengeAgent:handlePM_YuHuiChallengeFightRes(status, msg)
	if status == 0 then
		YuHuiChallengeController.instance:handleChallengeFight(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeError, status)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function YuHuiChallengeAgent:sendPM_YuHuiChallengeResetReq(challengeId)
	local req = YuHuiChallengeExtension_pb.PM_YuHuiChallengeResetReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YuHuiChallengeAgent:handlePM_YuHuiChallengeResetRes(status, msg)
	if status == 0 then
		YuHuiChallengeController.instance:handleChallengeReset(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeError, status)
	end
end

function YuHuiChallengeAgent:handlePM_YuHuiChallengeFightEndRes(status, msg)
	if status == 0 then
		YuHuiChallengeController.instance:handleChallengeFightEnd(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.YuHuiCallengeError, status)
	end
end

function YuHuiChallengeAgent:sendPM_YuHuiChallengeUpgradeSignInBuffReq(challengeId)
	local req = YuHuiChallengeExtension_pb.PM_YuHuiChallengeUpgradeSignInBuffReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YuHuiChallengeAgent:handlePM_YuHuiChallengeUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		YuHuiChallengeController.instance:onSignBuff(msg)
	end
end

YuHuiChallengeAgent.instance = YuHuiChallengeAgent.New()

return YuHuiChallengeAgent
