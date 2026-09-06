-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/agent/OriginDiShiTianClgAgent.lua

module("logic.extensions.origindishitianclg.agent.OriginDiShiTianClgAgent", package.seeall)

local OriginDiShiTianClgAgent = class("OriginDiShiTianClgAgent", BaseAgent)

function OriginDiShiTianClgAgent:sendPM_OriginDiShiTianClgGetInfoReq(activityId)
	local req = OriginDiShiTianClgExtension_pb.PM_OriginDiShiTianClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDiShiTianClgAgent:handlePM_OriginDiShiTianClgGetInfoRes(status, msg)
	if status == 0 then
		OriginDiShiTianController.instance:handlePM_OriginDiShiTianClgGetInfoRes(msg)
	end
end

function OriginDiShiTianClgAgent:sendPM_OriginDiShiTianClgFightReq(activityId, stageId, form)
	local req = OriginDiShiTianClgExtension_pb.PM_OriginDiShiTianClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginDiShiTianClgAgent:handlePM_OriginDiShiTianClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginDiShiTianClgAgent:handlePM_NotifyOriginDiShiTianClgFightRes(status, msg)
	if status == 0 then
		OriginDiShiTianController.instance:handlePM_NotifyOriginDiShiTianClgFightRes(msg)
	end
end

function OriginDiShiTianClgAgent:sendPM_OriginDiShiTianClgResetReq(activityId)
	local req = OriginDiShiTianClgExtension_pb.PM_OriginDiShiTianClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDiShiTianClgAgent:handlePM_OriginDiShiTianClgResetRes(status, msg)
	if status == 0 then
		OriginDiShiTianController.instance:handlePM_OriginDiShiTianClgResetRes(msg)
	end
end

function OriginDiShiTianClgAgent:sendPM_OriginDiShiTianClgConfirmReq(activityId, stageId, save)
	local req = OriginDiShiTianClgExtension_pb.PM_OriginDiShiTianClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginDiShiTianClgAgent:handlePM_OriginDiShiTianClgConfirmRes(status, msg)
	if status == 0 then
		OriginDiShiTianController.instance:handlePM_OriginDiShiTianClgConfirmRes(msg)
	end
end

OriginDiShiTianClgAgent.instance = OriginDiShiTianClgAgent.New()

return OriginDiShiTianClgAgent
