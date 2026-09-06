-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/agent/SkyPeakAgent.lua

module("logic.extensions.skypeak.agent.SkyPeakAgent", package.seeall)

local SkyPeakAgent = class("SkyPeakAgent", BaseAgent)

function SkyPeakAgent:sendPM_SkyPeakGetInfoReq(activityId)
	local req = SkyPeakExtension_pb.PM_SkyPeakGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakGetInfoRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakGetInfoRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakGetStageInfoReq(activityId, stageId)
	local req = SkyPeakExtension_pb.PM_SkyPeakGetStageInfoReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakGetStageInfoRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakGetStageInfoRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakChallengeStageReq(activityId, stageId, form_pb)
	local req = SkyPeakExtension_pb.PM_SkyPeakChallengeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakChallengeStageRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakChallengeStageRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakChallengeBossReq(activityId, bossId, form_pb)
	local req = SkyPeakExtension_pb.PM_SkyPeakChallengeBossReq()

	req.activityId = activityId
	req.bossId = bossId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakChallengeBossRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakChallengeBossRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakSweepReq(activityId)
	local req = SkyPeakExtension_pb.PM_SkyPeakSweepReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakSweepRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakSweepRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakUnlockBuffNodeReq(activityId, nodeId)
	local req = SkyPeakExtension_pb.PM_SkyPeakUnlockBuffNodeReq()

	req.activityId = activityId
	req.nodeId = nodeId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakUnlockBuffNodeRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakUnlockBuffNodeRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakResetBuffReq(activityId)
	local req = SkyPeakExtension_pb.PM_SkyPeakResetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakResetBuffRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakResetBuffRes(msg)
	end
end

function SkyPeakAgent:sendPM_SkyPeakGetRankInfoReq(activityId)
	local req = SkyPeakExtension_pb.PM_SkyPeakGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkyPeakAgent:handlePM_SkyPeakGetRankInfoRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:handlePM_SkyPeakGetRankInfoRes(msg)
	end
end

function SkyPeakAgent:handlePM_Notify_SkyPeakStageChallengeResultRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:notifyStageChallengeResult(msg)
	end
end

function SkyPeakAgent:handlePM_Notify_SkyPeakBossChallengeResultRes(status, msg)
	if status == 0 then
		SkyPeakController.instance:notifyBossChallengeResult(msg)
	end
end

SkyPeakAgent.instance = SkyPeakAgent.New()

return SkyPeakAgent
