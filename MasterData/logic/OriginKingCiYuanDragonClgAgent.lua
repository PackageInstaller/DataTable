-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/agent/OriginKingCiYuanDragonClgAgent.lua

module("logic.extensions.originkingciyuandragonclg.agent.OriginKingCiYuanDragonClgAgent", package.seeall)

local OriginKingCiYuanDragonClgAgent = class("OriginKingCiYuanDragonClgAgent", BaseAgent)

function OriginKingCiYuanDragonClgAgent:sendPM_OriginKingCiYuanDragonClgGetInfoReq(activityId)
	local req = OriginKingCiYuanDragonClgExtension_pb.PM_OriginKingCiYuanDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingCiYuanDragonClgAgent:handlePM_OriginKingCiYuanDragonClgGetInfoRes(status, msg)
	if status == 0 then
		OriginKingCiYuanDragonClgController.instance:handlePM_OriginKingCiYuanDragonClgGetInfoRes(msg)
	end
end

function OriginKingCiYuanDragonClgAgent:sendPM_OriginKingCiYuanDragonClgFightReq(activityId, stageId, form)
	local req = OriginKingCiYuanDragonClgExtension_pb.PM_OriginKingCiYuanDragonClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingCiYuanDragonClgAgent:handlePM_OriginKingCiYuanDragonClgFightRes(status, msg)
	if status == 0 then
		OriginKingCiYuanDragonClgController.instance:handlePM_OriginKingCiYuanDragonClgFightRes(msg)
	end
end

function OriginKingCiYuanDragonClgAgent:handlePM_OriginKingCiYuanDragonClgNotifyFightRes(status, msg)
	if status == 0 then
		OriginKingCiYuanDragonClgController.instance:handlePM_OriginKingCiYuanDragonClgNotifyFightRes(msg)
	end
end

function OriginKingCiYuanDragonClgAgent:sendPM_OriginKingCiYuanDragonClgConfirmReq(activityId, stageId)
	local req = OriginKingCiYuanDragonClgExtension_pb.PM_OriginKingCiYuanDragonClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginKingCiYuanDragonClgAgent:handlePM_OriginKingCiYuanDragonClgConfirmRes(status, msg)
	OriginKingCiYuanDragonClgController.instance:handlePM_OriginKingCiYuanDragonClgConfirmRes(status, msg)
end

function OriginKingCiYuanDragonClgAgent:sendPM_OriginKingCiYuanDragonClgResetReq(activityId)
	local req = OriginKingCiYuanDragonClgExtension_pb.PM_OriginKingCiYuanDragonClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingCiYuanDragonClgAgent:handlePM_OriginKingCiYuanDragonClgResetRes(status, msg)
	if status == 0 then
		OriginKingCiYuanDragonClgController.instance:handlePM_OriginKingCiYuanDragonClgResetRes(msg)
	end
end

OriginKingCiYuanDragonClgAgent.instance = OriginKingCiYuanDragonClgAgent.New()

return OriginKingCiYuanDragonClgAgent
