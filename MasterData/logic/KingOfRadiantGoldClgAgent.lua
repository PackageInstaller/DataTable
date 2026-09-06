-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/agent/KingOfRadiantGoldClgAgent.lua

module("logic.extensions.kingofradiantgoldclg.agent.KingOfRadiantGoldClgAgent", package.seeall)

local KingOfRadiantGoldClgAgent = class("KingOfRadiantGoldClgAgent", BaseAgent)

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgInfoReq(activityId)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgInfoRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgInfoRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgChallengeReq(activityId, challengeId, stageId, form)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgChallengeReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgChallengeRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgChallengeRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgUpgradeBuffReq(activityId, buffId)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgUpgradeBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgUpgradeBuffRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgUpgradeBuffRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgResetBuffReq(activityId, buffId)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgResetBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgResetBuffRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgResetBuffRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgOneKeyPassReq(activityId, leftNum)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgOneKeyPassReq()

	req.activityId = activityId
	req.leftNum = leftNum

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgOneKeyPassRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgOneKeyPassRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:sendPM_KingOfRadiantGoldClgGainPetReq(activityId)
	local req = KingOfRadiantGoldClgExtension_pb.PM_KingOfRadiantGoldClgGainPetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingOfRadiantGoldClgAgent:handlePM_KingOfRadiantGoldClgGainPetRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_KingOfRadiantGoldClgGainPetRes(msg)
	end
end

function KingOfRadiantGoldClgAgent:handlePM_NotifyKingOfRadiantGoldClgFinishRes(status, msg)
	if status == 0 then
		KingOfRadiantGoldClgController.instance:handlePM_NotifyKingOfRadiantGoldClgFinishRes(msg)
	end
end

KingOfRadiantGoldClgAgent.instance = KingOfRadiantGoldClgAgent.New()

return KingOfRadiantGoldClgAgent
