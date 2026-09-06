-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/agent/JudgmentDragonClgAgent.lua

module("logic.extensions.judgmentdragonclg.agent.JudgmentDragonClgAgent", package.seeall)

local JudgmentDragonClgAgent = class("JudgmentDragonClgAgent", BaseAgent)

function JudgmentDragonClgAgent:sendPM_JudgmentDragonClgGetInfoReq(activityId)
	local req = JudgmentDragonClgExtension_pb.PM_JudgmentDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JudgmentDragonClgAgent:handlePM_JudgmentDragonClgGetInfoRes(status, msg)
	if status == 0 then
		JudgmentDragonClgController.instance:handlePM_JudgmentDragonClgGetInfoRes(msg)
	end
end

function JudgmentDragonClgAgent:sendPM_JudgmentDragonClgFightReq(activityId, phaseId, stageId, form)
	local req = JudgmentDragonClgExtension_pb.PM_JudgmentDragonClgFightReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function JudgmentDragonClgAgent:handlePM_JudgmentDragonClgFightRes(status, msg)
	if status == 0 then
		JudgmentDragonClgController.instance:handlePM_JudgmentDragonClgFightRes(msg)
	end
end

function JudgmentDragonClgAgent:sendPM_JudgmentDragonClgResetReq(activityId, phaseId, stageId)
	local req = JudgmentDragonClgExtension_pb.PM_JudgmentDragonClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	self:sendMsg(req)
end

function JudgmentDragonClgAgent:handlePM_JudgmentDragonClgResetRes(status, msg)
	if status == 0 then
		JudgmentDragonClgController.instance:handlePM_JudgmentDragonClgResetRes(msg)
	end
end

function JudgmentDragonClgAgent:handlePM_JudgmentDragonNotifyFightRes(status, msg)
	if status == 0 then
		JudgmentDragonClgController.instance:handlePM_JudgmentDragonNotifyFightRes(msg)
	end
end

JudgmentDragonClgAgent.instance = JudgmentDragonClgAgent.New()

return JudgmentDragonClgAgent
