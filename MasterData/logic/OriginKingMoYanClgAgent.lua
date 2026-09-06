-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/agent/OriginKingMoYanClgAgent.lua

module("logic.extensions.originkingmoyanclg.agent.OriginKingMoYanClgAgent", package.seeall)

local OriginKingMoYanClgAgent = class("OriginKingMoYanClgAgent", BaseAgent)

function OriginKingMoYanClgAgent:sendPM_OriginKingMoYanClgGetInfoReq(activityId)
	local req = OriginKingMoYanClgExtension_pb.PM_OriginKingMoYanClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgGetInfoRes(status, msg)
	if status == 0 then
		OriginKingMoYanClgController.instance:handlePM_OriginKingMoYanClgGetInfoRes(msg)
	end
end

function OriginKingMoYanClgAgent:sendPM_OriginKingMoYanClgSetItemReq(activityId, phaseId, type, pointId)
	local req = OriginKingMoYanClgExtension_pb.PM_OriginKingMoYanClgSetItemReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.type = type
	req.pointId = pointId

	self:sendMsg(req)
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgSetItemRes(status, msg)
	if status == 0 then
		OriginKingMoYanClgController.instance:handlePM_OriginKingMoYanClgSetItemRes(msg)
	end
end

function OriginKingMoYanClgAgent:sendPM_OriginKingMoYanClgFightReq(activityId, phaseId, stageId, form)
	local req = OriginKingMoYanClgExtension_pb.PM_OriginKingMoYanClgFightReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgFightNotifyRes(status, msg)
	if status == 0 then
		OriginKingMoYanClgController.instance:handlePM_OriginKingMoYanClgFightNotifyRes(msg)
	end
end

function OriginKingMoYanClgAgent:sendPM_OriginKingMoYanClgResetReq(activityId, phaseId)
	local req = OriginKingMoYanClgExtension_pb.PM_OriginKingMoYanClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgResetRes(status, msg)
	if status == 0 then
		OriginKingMoYanClgController.instance:handlePM_OriginKingMoYanClgResetRes(msg)
	end
end

function OriginKingMoYanClgAgent:sendPM_OriginKingMoYanClgResetPointReq(activityId, phaseId, pointId)
	local req = OriginKingMoYanClgExtension_pb.PM_OriginKingMoYanClgResetPointReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.pointId = pointId

	self:sendMsg(req)
end

function OriginKingMoYanClgAgent:handlePM_OriginKingMoYanClgResetPointRes(status, msg)
	if status == 0 then
		OriginKingMoYanClgController.instance:handlePM_OriginKingMoYanClgResetPointRes(msg)
	end
end

OriginKingMoYanClgAgent.instance = OriginKingMoYanClgAgent.New()

return OriginKingMoYanClgAgent
