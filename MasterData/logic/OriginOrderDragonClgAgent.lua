-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originorderdragonclg/agent/OriginOrderDragonClgAgent.lua

module("logic.extensions.originorderdragonclg.agent.OriginOrderDragonClgAgent", package.seeall)

local OriginOrderDragonClgAgent = class("OriginOrderDragonClgAgent", BaseAgent)

function OriginOrderDragonClgAgent:sendPM_OriginOrderDragonClgGetInfoReq(activityId)
	local req = OriginOrderDragonClgExtension_pb.PM_OriginOrderDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginOrderDragonClgAgent:handlePM_OriginOrderDragonClgGetInfoRes(status, msg)
	if status == 0 then
		OriginOrderDragonClgController.instance:handlePM_OriginOrderDragonClgGetInfoRes(msg)
	end
end

function OriginOrderDragonClgAgent:sendPM_OriginOrderDragonClgFightReq(activityId, stageId, form_pb)
	local req = OriginOrderDragonClgExtension_pb.PM_OriginOrderDragonClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginOrderDragonClgAgent:handlePM_OriginOrderDragonClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginOrderDragonClgAgent:sendPM_OriginOrderDragonClgResetReq(activityId)
	local req = OriginOrderDragonClgExtension_pb.PM_OriginOrderDragonClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginOrderDragonClgAgent:handlePM_OriginOrderDragonClgResetRes(status, msg)
	if status == 0 then
		OriginOrderDragonClgController.instance:handlePM_OriginOrderDragonClgResetRes(msg)
	end
end

function OriginOrderDragonClgAgent:sendPM_OriginOrderDragonClgConfirmReq(activityId, stageId, save)
	local req = OriginOrderDragonClgExtension_pb.PM_OriginOrderDragonClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginOrderDragonClgAgent:handlePM_OriginOrderDragonClgConfirmRes(status, msg)
	if status == 0 then
		OriginOrderDragonClgController.instance:handlePM_OriginOrderDragonClgConfirmRes(msg)
	end
end

function OriginOrderDragonClgAgent:handlePM_OriginOrderDragonClgNotifyFightRes(status, msg)
	if status == 0 then
		OriginOrderDragonClgController.instance:notifyFightResult(msg)
	end
end

OriginOrderDragonClgAgent.instance = OriginOrderDragonClgAgent.New()

return OriginOrderDragonClgAgent
