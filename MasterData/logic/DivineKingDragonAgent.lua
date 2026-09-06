-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/agent/DivineKingDragonAgent.lua

module("logic.extensions.divinekingdragon.agent.DivineKingDragonAgent", package.seeall)

local DivineKingDragonAgent = class("DivineKingDragonAgent", BaseAgent)

function DivineKingDragonAgent:sendPM_DivineKingDragonGetInfoReq(actId)
	local req = DivineKingDragonExtension_pb.PM_DivineKingDragonGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function DivineKingDragonAgent:handlePM_DivineKingDragonGetInfoRes(status, msg)
	if status == 0 then
		DivineKingDragonChallengeController.instance:handlePM_DivineKingDragonGetInfoRes(msg)
	end
end

function DivineKingDragonAgent:sendPM_DivineKingDragonChallengeReq(actId, stageId, teamId, form)
	local req = DivineKingDragonExtension_pb.PM_DivineKingDragonChallengeReq()

	req.actId = actId
	req.stageId = stageId
	req.teamId = teamId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKingDragonAgent:handlePM_DivineKingDragonChallengeRes(status, msg)
	DivineKingDragonChallengeController.instance:handlePM_DivineKingDragonChallengeRes(status, msg)
end

function DivineKingDragonAgent:sendPM_DivineKingDragonGainPrizeReq(actId, stageId)
	local req = DivineKingDragonExtension_pb.PM_DivineKingDragonGainPrizeReq()

	req.actId = actId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineKingDragonAgent:handlePM_DivineKingDragonGainPrizeRes(status, msg)
	if status == 0 then
		DivineKingDragonChallengeController.instance:handlePM_DivineKingDragonGainPrizeRes(msg)
	end
end

function DivineKingDragonAgent:sendPM_DivineKingDragonResetReq(actId, stageId, teamId)
	local req = DivineKingDragonExtension_pb.PM_DivineKingDragonResetReq()

	req.actId = actId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function DivineKingDragonAgent:handlePM_DivineKingDragonResetRes(status, msg)
	if status == 0 then
		DivineKingDragonChallengeController.instance:handlePM_DivineKingDragonResetRes(msg)
	end
end

function DivineKingDragonAgent:handlePM_DivineKingDragonNotifyChallengeRes(status, msg)
	if status == 0 then
		DivineKingDragonChallengeController.instance:handlePM_DivineKingDragonNotifyChallengeRes(msg)
	end
end

DivineKingDragonAgent.instance = DivineKingDragonAgent.New()

return DivineKingDragonAgent
