-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/agent/GulasClgAgent.lua

module("logic.extensions.gulasclg.agent.GulasClgAgent", package.seeall)

local GulasClgAgent = class("GulasClgAgent", BaseAgent)

function GulasClgAgent:sendPM_GulasClgGetInfoReq(activityId)
	local req = GulasClgExtension_pb.PM_GulasClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GulasClgAgent:handlePM_GulasClgGetInfoRes(status, msg)
	if status == 0 then
		GulasController.instance:onGetInfo(msg)
	end
end

function GulasClgAgent:sendPM_GulasClgChallengeReq(activityId, phaseId, stageId, form_pb)
	local req = GulasClgExtension_pb.PM_GulasClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function GulasClgAgent:handlePM_GulasClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GulasClgAgent:sendPM_GulasClgResetStageReq(activityId, phaseId, stageId)
	local req = GulasClgExtension_pb.PM_GulasClgResetStageReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	self:sendMsg(req)
end

function GulasClgAgent:handlePM_GulasClgResetStageRes(status, msg)
	if status == 0 then
		GulasController.instance:onResetStage(msg)
	end
end

function GulasClgAgent:handlePM_Notify_GulasClgChallengeEndRes(status, msg)
	if status == 0 then
		GulasController.instance:handleFightRes(msg)
	end
end

GulasClgAgent.instance = GulasClgAgent.New()

return GulasClgAgent
