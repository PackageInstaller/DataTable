-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/agent/OriginGodDragonClgAgent.lua

module("logic.extensions.origingoddragonclg.agent.OriginGodDragonClgAgent", package.seeall)

local OriginGodDragonClgAgent = class("OriginGodDragonClgAgent", BaseAgent)

function OriginGodDragonClgAgent:sendPM_OriginGodDragonClgInfoReq(activityId)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonClgInfoRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_OriginGodDragonClgInfoRes(msg)
	end
end

function OriginGodDragonClgAgent:sendPM_OriginGodDragonClgChallengeReq(activityId, zoneId, stageId, form)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonClgChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonClgChallengeRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_OriginGodDragonClgChallengeRes(msg)
	end
end

function OriginGodDragonClgAgent:sendPM_OriginGodDragonClgConfirmReq(activityId, zoneId, stageId, confirm)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonClgConfirmReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonClgConfirmRes(status, msg)
	OriginGodDragonClgController.instance:handlePM_OriginGodDragonClgConfirmRes(status, msg)
end

function OriginGodDragonClgAgent:sendPM_OriginGodDragonEffectBuffReq(activityId, zoneId, stageId)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonEffectBuffReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonEffectBuffRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_OriginGodDragonEffectBuffRes(msg)
	end
end

function OriginGodDragonClgAgent:sendPM_OriginGodDragonBacktrackReq(activityId, zoneId, stageId)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonBacktrackReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonBacktrackRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_OriginGodDragonBacktrackRes(msg)
	end
end

function OriginGodDragonClgAgent:sendPM_OriginGodDragonResetReq(activityId)
	local req = OriginGodDragonClgExtension_pb.PM_OriginGodDragonResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginGodDragonClgAgent:handlePM_OriginGodDragonResetRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_OriginGodDragonResetRes(msg)
	end
end

function OriginGodDragonClgAgent:handlePM_NotifyOriginGodDragonChallengeFinishRes(status, msg)
	if status == 0 then
		OriginGodDragonClgController.instance:handlePM_NotifyOriginGodDragonChallengeFinishRes(msg)
	end
end

OriginGodDragonClgAgent.instance = OriginGodDragonClgAgent.New()

return OriginGodDragonClgAgent
