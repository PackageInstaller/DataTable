-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/agent/DemonDescendAgent.lua

module("logic.extensions.demondescend.agent.DemonDescendAgent", package.seeall)

local DemonDescendAgent = class("DemonDescendAgent", BaseAgent)

function DemonDescendAgent:sendPM_DemonDescendInfoReq(activityId)
	local req = DemonDescendExtension_pb.PM_DemonDescendInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendInfoRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendInfoRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendUnlockBuffReq(activityId, buffId)
	local req = DemonDescendExtension_pb.PM_DemonDescendUnlockBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendUnlockBuffRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendUnlockBuffRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendGainProgressPrizeReq(activityId, progressId)
	local req = DemonDescendExtension_pb.PM_DemonDescendGainProgressPrizeReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendGainProgressPrizeRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendGainProgressPrizeRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendCheckInReq(activityId)
	local req = DemonDescendExtension_pb.PM_DemonDescendCheckInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendCheckInRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendCheckInRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendResetBuffReq(activityId)
	local req = DemonDescendExtension_pb.PM_DemonDescendResetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendResetBuffRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendResetBuffRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendStageChallengeReq(activityId, form, stageId)
	local req = DemonDescendExtension_pb.PM_DemonDescendStageChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendStageChallengeRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendStageChallengeRes(msg)
	end
end

function DemonDescendAgent:handlePM_DemonDescendNotifyStageChallengeRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendNotifyStageChallengeRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendBossChallengeReq(activityId, form, buffId, isTrial)
	local req = DemonDescendExtension_pb.PM_DemonDescendBossChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	for _, v in ipairs(buffId) do
		req.buffId:append(v)
	end

	req.isTrial = isTrial

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendBossChallengeRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendBossChallengeRes(msg)
	end
end

function DemonDescendAgent:handlePM_DemonDescendNotifyBossChallengeRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendNotifyBossChallengeRes(msg)
	end
end

function DemonDescendAgent:sendPM_DemonDescendRankViewReq(activityId)
	local req = DemonDescendExtension_pb.PM_DemonDescendRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DemonDescendAgent:handlePM_DemonDescendRankViewRes(status, msg)
	if status == 0 then
		DemonDescendController.instance:handlePM_DemonDescendRankViewRes(msg)
	end
end

DemonDescendAgent.instance = DemonDescendAgent.New()

return DemonDescendAgent
