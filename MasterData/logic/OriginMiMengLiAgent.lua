-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/agent/OriginMiMengLiAgent.lua

module("logic.extensions.originmimengli.agent.OriginMiMengLiAgent", package.seeall)

local OriginMiMengLiAgent = class("OriginMiMengLiAgent", BaseAgent)

function OriginMiMengLiAgent:sendPM_OriginMiMengLiInfoReq(activityId)
	local req = OriginMiMengLiExtension_pb.PM_OriginMiMengLiInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginMiMengLiAgent:handlePM_OriginMiMengLiInfoRes(status, msg)
	if status == 0 then
		OriginMiMengLiController.instance:handlePM_OriginMiMengLiInfoRes(msg)
	end
end

function OriginMiMengLiAgent:sendPM_OriginMiMengLiClgReq(activityId, form_pb, stageId)
	local req = OriginMiMengLiExtension_pb.PM_OriginMiMengLiClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function OriginMiMengLiAgent:handlePM_OriginMiMengLiClgRes(status, msg)
	if status == 0 then
		OriginMiMengLiController.instance:handlePM_OriginMiMengLiClgRes(msg)
	end
end

function OriginMiMengLiAgent:handlePM_OriginMiMengLiNotifyClgRes(status, msg)
	if status == 0 then
		OriginMiMengLiController.instance:handlePM_OriginMiMengLiNotifyClgRes(msg)
	end
end

OriginMiMengLiAgent.instance = OriginMiMengLiAgent.New()

return OriginMiMengLiAgent
