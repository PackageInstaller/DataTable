-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/agent/OriginZhengliAgent.lua

module("logic.extensions.originzhengli.agent.OriginZhengliAgent", package.seeall)

local OriginZhengliAgent = class("OriginZhengliAgent", BaseAgent)

function OriginZhengliAgent:sendPM_OriginZhengliInfoReq(activityId)
	local req = OriginZhengliExtension_pb.PM_OriginZhengliInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginZhengliAgent:handlePM_OriginZhengliInfoRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:handlePM_OriginZhengliInfoRes(msg)
	end
end

function OriginZhengliAgent:sendPM_OriginZhengliClgReq(activityId, form_pb, stageId, activateBuff)
	local req = OriginZhengliExtension_pb.PM_OriginZhengliClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId
	req.activateBuff = activateBuff

	self:sendMsg(req)
end

function OriginZhengliAgent:handlePM_OriginZhengliClgRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:handlePM_OriginZhengliClgRes(msg)
	end
end

function OriginZhengliAgent:sendPM_OriginZhengliResetReq(activityId)
	local req = OriginZhengliExtension_pb.PM_OriginZhengliResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginZhengliAgent:handlePM_OriginZhengliResetRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:handlePM_OriginZhengliResetRes(msg)
	end
end

function OriginZhengliAgent:sendPM_OriginZhengliSaveClgReq(activityId)
	local req = OriginZhengliExtension_pb.PM_OriginZhengliSaveClgReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginZhengliAgent:handlePM_OriginZhengliSaveClgRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:handlePM_OriginZhengliSaveClgRes(msg)
	end
end

function OriginZhengliAgent:handlePM_OriginZhengliNotifyClgRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:notifyClgResult(msg)
	end
end

function OriginZhengliAgent:sendPM_OriginZhengliSelectRouteReq(activityId, routeId)
	local req = OriginZhengliExtension_pb.PM_OriginZhengliSelectRouteReq()

	req.activityId = activityId
	req.routeId = routeId

	self:sendMsg(req)
end

function OriginZhengliAgent:handlePM_OriginZhengliSelectRouteRes(status, msg)
	if status == 0 then
		OriginZhengliController.instance:handlePM_OriginZhengliSelectRouteRes(msg)
	end
end

OriginZhengliAgent.instance = OriginZhengliAgent.New()

return OriginZhengliAgent
