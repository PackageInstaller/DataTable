-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/agent/GodARuiShiChallengeAgent.lua

module("logic.extensions.godaruishichallenge.agent.GodARuiShiChallengeAgent", package.seeall)

local GodARuiShiChallengeAgent = class("GodARuiShiChallengeAgent", BaseAgent)

GodARuiShiChallengeAgent.PM_GodARuiShiChallengeInfoRes = "GodARuiShiChallengeAgent_PM_GodARuiShiChallengeInfoRes"
GodARuiShiChallengeAgent.PM_GodARuiShiChallengeSkipRes = "GodARuiShiChallengeAgent_PM_GodARuiShiChallengeSkipRes"
GodARuiShiChallengeAgent.PM_GodARuiShiChallengeStageRes = "GodARuiShiChallengeAgent_PM_GodARuiShiChallengeStageRes"
GodARuiShiChallengeAgent.PM_GodARuiShiChallengeBossRes = "GodARuiShiChallengeAgent_PM_GodARuiShiChallengeBossRes"
GodARuiShiChallengeAgent.PM_GodARuiShiChallengeOneKeyPassRes = "GodARuiShiChallengeAgent_PM_GodARuiShiChallengeOneKeyPassRes"
GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeStageEndRes = "GodARuiShiChallengeAgent_PM_NotifyGodARuiShiChallengeStageEndRes"
GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeBossEndRes = "GodARuiShiChallengeAgent_PM_NotifyGodARuiShiChallengeBossEndRes"

function GodARuiShiChallengeAgent:sendPM_GodARuiShiChallengeInfoReq(challengeId)
	local req = GodARuiShiChallengeExtension_pb.PM_GodARuiShiChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function GodARuiShiChallengeAgent:handlePM_GodARuiShiChallengeInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeInfoRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:sendPM_GodARuiShiChallengeSkipReq(challengeId)
	local req = GodARuiShiChallengeExtension_pb.PM_GodARuiShiChallengeSkipReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function GodARuiShiChallengeAgent:handlePM_GodARuiShiChallengeSkipRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeSkipRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:sendPM_GodARuiShiChallengeStageReq(challengeId, stageId, simpleForm)
	local req = GodARuiShiChallengeExtension_pb.PM_GodARuiShiChallengeStageReq()

	req.challengeId = challengeId
	req.stageId = stageId

	if simpleForm ~= nil then
		req.form:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function GodARuiShiChallengeAgent:handlePM_GodARuiShiChallengeStageRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeStageRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:sendPM_GodARuiShiChallengeBossReq(challengeId, simpleForm)
	local req = GodARuiShiChallengeExtension_pb.PM_GodARuiShiChallengeBossReq()

	req.challengeId = challengeId

	if simpleForm ~= nil then
		req.form:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function GodARuiShiChallengeAgent:handlePM_GodARuiShiChallengeBossRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeBossRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:sendPM_GodARuiShiChallengeOneKeyPassReq(challengeId)
	local req = GodARuiShiChallengeExtension_pb.PM_GodARuiShiChallengeOneKeyPassReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function GodARuiShiChallengeAgent:handlePM_GodARuiShiChallengeOneKeyPassRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeOneKeyPassRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:handlePM_NotifyGodARuiShiChallengeStageEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeStageEndRes, status, msg)
	end
end

function GodARuiShiChallengeAgent:handlePM_NotifyGodARuiShiChallengeBossEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeBossEndRes, status, msg)
	end
end

GodARuiShiChallengeAgent.instance = GodARuiShiChallengeAgent.New()

return GodARuiShiChallengeAgent
