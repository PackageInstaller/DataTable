-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/agent/OriginLightDimensionAgent.lua

module("logic.extensions.originlightdimension.agent.OriginLightDimensionAgent", package.seeall)

local OriginLightDimensionAgent = class("OriginLightDimensionAgent", BaseAgent)

function OriginLightDimensionAgent:sendPM_OriginLightDimensionInfoReq(activityId)
	local req = OriginLightDimensionExtension_pb.PM_OriginLightDimensionInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionInfoRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionInfoRes(msg)
	end
end

function OriginLightDimensionAgent:sendPM_OriginLightDimensionResetExtremeReq(activityId, stageId)
	local req = OriginLightDimensionExtension_pb.PM_OriginLightDimensionResetExtremeReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionResetExtremeRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionResetExtremeRes(msg)
	end
end

function OriginLightDimensionAgent:sendPM_OriginLightDimensionExtremeClgReq(activityId, stageId, form)
	local req = OriginLightDimensionExtension_pb.PM_OriginLightDimensionExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionExtremeClgRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionExtremeClgRes(msg)
	end
end

function OriginLightDimensionAgent:sendPM_OriginLightDimensionNormalClgReq(activityId, stageId, form)
	local req = OriginLightDimensionExtension_pb.PM_OriginLightDimensionNormalClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionNormalClgRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionNormalClgRes(msg)
	end
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionNotifyExtremeClgRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionNotifyExtremeClgRes(msg)
	end
end

function OriginLightDimensionAgent:handlePM_OriginLightDimensionNotifyNormalClgRes(status, msg)
	if status == 0 then
		OriginLightDimensionController.instance:handlePM_OriginLightDimensionNotifyNormalClgRes(msg)
	end
end

OriginLightDimensionAgent.instance = OriginLightDimensionAgent.New()

return OriginLightDimensionAgent
