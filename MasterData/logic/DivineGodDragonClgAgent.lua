-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/agent/DivineGodDragonClgAgent.lua

module("logic.extensions.divinegoddragonclg.agent.DivineGodDragonClgAgent", package.seeall)

local DivineGodDragonClgAgent = class("DivineGodDragonClgAgent", BaseAgent)

function DivineGodDragonClgAgent:sendPM_DivineGodDragonClgInfoReq(activityId)
	local req = DivineGodDragonClgExtension_pb.PM_DivineGodDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineGodDragonClgAgent:handlePM_DivineGodDragonClgInfoRes(status, msg)
	if status == 0 then
		DivineGodDragonClgController.instance:handlePM_DivineGodDragonClgInfoRes(msg)
	end
end

function DivineGodDragonClgAgent:sendPM_DivineGodDragonChallengeReq(activityId, stageId, form)
	local req = DivineGodDragonClgExtension_pb.PM_DivineGodDragonChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineGodDragonClgAgent:handlePM_DivineGodDragonChallengeRes(status, msg)
	if status == 0 then
		DivineGodDragonClgController.instance:handlePM_DivineGodDragonChallengeRes(msg)
	end
end

function DivineGodDragonClgAgent:handlePM_NotifyDivineGodDragonChallengeEndRes(status, msg)
	if status == 0 then
		DivineGodDragonClgController.instance:handlePM_NotifyDivineGodDragonChallengeEndRes(msg)
	end
end

function DivineGodDragonClgAgent:sendPM_DivineGodDragonGainPrizeReq(activityId, prizeId)
	local req = DivineGodDragonClgExtension_pb.PM_DivineGodDragonGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineGodDragonClgAgent:handlePM_DivineGodDragonGainPrizeRes(status, msg)
	if status == 0 then
		DivineGodDragonClgController.instance:handlePM_DivineGodDragonGainPrizeRes(msg)
	end
end

function DivineGodDragonClgAgent:sendPM_DivineGodDragonGetRankReq(activityId)
	local req = DivineGodDragonClgExtension_pb.PM_DivineGodDragonGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineGodDragonClgAgent:handlePM_DivineGodDragonGetRankRes(status, msg)
	if status == 0 then
		DivineGodDragonClgController.instance:handlePM_DivineGodDragonGetRankRes(msg)
	end
end

DivineGodDragonClgAgent.instance = DivineGodDragonClgAgent.New()

return DivineGodDragonClgAgent
