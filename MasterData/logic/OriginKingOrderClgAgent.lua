-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/agent/OriginKingOrderClgAgent.lua

module("logic.extensions.originkingorderclg.agent.OriginKingOrderClgAgent", package.seeall)

local OriginKingOrderClgAgent = class("OriginKingOrderClgAgent", BaseAgent)

function OriginKingOrderClgAgent:sendPM_OriginKingOrderClgGetInfoReq(activityId)
	local req = OriginKingOrderClgExtension_pb.PM_OriginKingOrderClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingOrderClgAgent:handlePM_OriginKingOrderClgGetInfoRes(status, msg)
	if status == 0 then
		OriginKingOrderClgController.instance:handlePM_OriginKingOrderClgGetInfoRes(msg)
	end
end

function OriginKingOrderClgAgent:sendPM_OriginKingOrderClgFightReq(activityId, stageId, form)
	local req = OriginKingOrderClgExtension_pb.PM_OriginKingOrderClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingOrderClgAgent:handlePM_OriginKingOrderClgFightRes(status, msg)
	if status == 0 then
		OriginKingOrderClgController.instance:handlePM_OriginKingOrderClgFightRes(msg)
	end
end

function OriginKingOrderClgAgent:handlePM_Notify_OriginKingOrderClgFightRes(status, msg)
	if status == 0 then
		OriginKingOrderClgController.instance:handlePM_Notify_OriginKingOrderClgFightRes(msg)
	end
end

function OriginKingOrderClgAgent:sendPM_OriginKingOrderClgResetReq(activityId)
	local req = OriginKingOrderClgExtension_pb.PM_OriginKingOrderClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingOrderClgAgent:handlePM_OriginKingOrderClgResetRes(status, msg)
	if status == 0 then
		OriginKingOrderClgController.instance:handlePM_OriginKingOrderClgResetRes(msg)
	end
end

function OriginKingOrderClgAgent:sendPM_OriginKingOrderClgConfirmReq(activityId, stageId, save)
	local req = OriginKingOrderClgExtension_pb.PM_OriginKingOrderClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginKingOrderClgAgent:handlePM_OriginKingOrderClgConfirmRes(status, msg)
	OriginKingOrderClgController.instance:handlePM_OriginKingOrderClgConfirmRes(status, msg)
end

OriginKingOrderClgAgent.instance = OriginKingOrderClgAgent.New()

return OriginKingOrderClgAgent
