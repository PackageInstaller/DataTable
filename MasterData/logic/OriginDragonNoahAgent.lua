-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/agent/OriginDragonNoahAgent.lua

module("logic.extensions.origindragonnoah.agent.OriginDragonNoahAgent", package.seeall)

local OriginDragonNoahAgent = class("OriginDragonNoahAgent", BaseAgent)

function OriginDragonNoahAgent:sendPM_OriginDragonNoahClgInfoReq(activityId)
	local req = OriginDragonNoahClgExtension_pb.PM_OriginDragonNoahClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDragonNoahAgent:handlePM_OriginDragonNoahClgInfoRes(status, msg)
	if status == 0 then
		OriginDragonNoahController.instance:handlePM_OriginDragonNoahClgInfoRes(msg)
	end
end

function OriginDragonNoahAgent:sendPM_OriginDragonNoahClgResetReq(activityId, stageId)
	local req = OriginDragonNoahClgExtension_pb.PM_OriginDragonNoahClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDragonNoahAgent:handlePM_OriginDragonNoahClgResetRes(status, msg)
	if status == 0 then
		OriginDragonNoahController.instance:handlePM_OriginDragonNoahClgResetRes(msg)
	end
end

function OriginDragonNoahAgent:sendPM_OriginDragonNoahClgChallengeReq(activityId, stageId, form)
	local req = OriginDragonNoahClgExtension_pb.PM_OriginDragonNoahClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginDragonNoahAgent:handlePM_OriginDragonNoahClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginDragonNoahAgent:handlePM_Notify_OriginDragonNoahClgChallengeRes(status, msg)
	if status == 0 then
		OriginDragonNoahController.instance:handlePM_Notify_OriginDragonNoahClgChallengeRes(msg)
	end
end

OriginDragonNoahAgent.instance = OriginDragonNoahAgent.New()

return OriginDragonNoahAgent
