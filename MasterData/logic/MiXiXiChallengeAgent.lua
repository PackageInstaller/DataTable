-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/MiXiXiChallengeAgent.lua

module("logic.extensions.mixixichallenge.agent.MiXiXiChallengeAgent", package.seeall)

local MiXiXiChallengeAgent = class("MiXiXiChallengeAgent", BaseAgent)

function MiXiXiChallengeAgent:sendPM_MiXiXiChallengeInfoReq(activityId)
	local req = MiXiXiChallengeExtension_pb.PM_MiXiXiChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiXiXiChallengeAgent:handlePM_MiXiXiChallengeInfoRes(status, msg)
	if status == 0 then
		MississiController.instance:handleGetInfo(msg)
	end
end

function MiXiXiChallengeAgent:sendPM_MiXiXiChallengeReq(activityId, teamId, form_pb)
	local req = MiXiXiChallengeExtension_pb.PM_MiXiXiChallengeReq()

	req.activityId = activityId
	req.teamId = teamId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MiXiXiChallengeAgent:handlePM_MiXiXiChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function MiXiXiChallengeAgent:sendPM_MiXiXiGainBuffReq(activityId)
	local req = MiXiXiChallengeExtension_pb.PM_MiXiXiGainBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiXiXiChallengeAgent:handlePM_MiXiXiGainBuffRes(status, msg)
	if status == 0 then
		MississiController.instance:handleGainBuff(msg)
	end
end

function MiXiXiChallengeAgent:handlePM_NotifyChallengeEndRes(status, msg)
	if status == 0 then
		MississiController.instance:handleChanllengeEnd(msg)
	end
end

MiXiXiChallengeAgent.instance = MiXiXiChallengeAgent.New()

return MiXiXiChallengeAgent
