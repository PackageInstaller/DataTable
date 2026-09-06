-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/agent/EternalChallengeAgent.lua

module("logic.extensions.eternalchallenge.agent.EternalChallengeAgent", package.seeall)

local EternalChallengeAgent = class("EternalChallengeAgent", BaseAgent)

function EternalChallengeAgent:sendPM_EternalChallengeInfoReq(activityId)
	local req = EternalChallengeExtension_pb.PM_EternalChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EternalChallengeAgent:handlePM_EternalChallengeInfoRes(status, msg)
	if status == 0 then
		EternalChallengeController.instance:handlePM_EternalChallengeInfoRes(msg)
	end
end

function EternalChallengeAgent:sendPM_EternalChallengeBuyPetReq(activityId, raceId)
	local req = EternalChallengeExtension_pb.PM_EternalChallengeBuyPetReq()

	req.activityId = activityId
	req.raceId = raceId

	self:sendMsg(req)
end

function EternalChallengeAgent:handlePM_EternalChallengeBuyPetRes(status, msg)
	if status == 0 then
		EternalChallengeController.instance:handlePM_EternalChallengeBuyPetRes(msg)
	end
end

function EternalChallengeAgent:sendPM_EternalChallengeUpgradeBuffReq(activityId, buffId)
	local req = EternalChallengeExtension_pb.PM_EternalChallengeUpgradeBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function EternalChallengeAgent:handlePM_EternalChallengeUpgradeBuffRes(status, msg)
	if status == 0 then
		EternalChallengeController.instance:handlePM_EternalChallengeUpgradeBuffRes(msg)
	end
end

function EternalChallengeAgent:sendPM_EternalChallengeFightReq(activityId, form)
	local req = EternalChallengeExtension_pb.PM_EternalChallengeFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function EternalChallengeAgent:handlePM_EternalChallengeFightRes(status, msg)
	EternalChallengeController.instance:handlePM_EternalChallengeFightRes(status, msg)
end

function EternalChallengeAgent:handlePM_NotifyEternalChallengeFightEndRes(status, msg)
	if status == 0 then
		EternalChallengeController.instance:handlePM_NotifyEternalChallengeFightEndRes(msg)
	end
end

EternalChallengeAgent.instance = EternalChallengeAgent.New()

return EternalChallengeAgent
