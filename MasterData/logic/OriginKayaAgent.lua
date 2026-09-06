-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/agent/OriginKayaAgent.lua

module("logic.extensions.originkaya.agent.OriginKayaAgent", package.seeall)

local OriginKayaAgent = class("OriginKayaAgent", BaseAgent)

function OriginKayaAgent:sendPM_OriginKayaInfoReq(activityId)
	local req = OriginKayaExtension_pb.PM_OriginKayaInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKayaAgent:handlePM_OriginKayaInfoRes(status, msg)
	if status == 0 then
		OriginKayaController.instance:handlePM_OriginKayaInfoRes(msg)
	end
end

function OriginKayaAgent:sendPM_OriginKayaResetReq(activityId, floorId)
	local req = OriginKayaExtension_pb.PM_OriginKayaResetReq()

	req.activityId = activityId
	req.floorId = floorId

	self:sendMsg(req)
end

function OriginKayaAgent:handlePM_OriginKayaResetRes(status, msg)
	if status == 0 then
		OriginKayaController.instance:handlePM_OriginKayaResetRes(msg)
	end
end

function OriginKayaAgent:sendPM_OriginKayaClgReq(activityId, form, floorId, stageId, useSeed)
	local req = OriginKayaExtension_pb.PM_OriginKayaClgReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.floorId = floorId
	req.stageId = stageId

	for i, v in ipairs(useSeed) do
		req.useSeed:append(v)
	end

	self:sendMsg(req)
end

function OriginKayaAgent:handlePM_OriginKayaClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginKayaAgent:handlePM_OriginKayaNotifyStageClgRes(status, msg)
	if status == 0 then
		OriginKayaController.instance:handlePM_OriginKayaNotifyStageClgRes(msg)
	end
end

OriginKayaAgent.instance = OriginKayaAgent.New()

return OriginKayaAgent
