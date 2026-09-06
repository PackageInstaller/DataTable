-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/agent/OriginAshlessDragonAgent.lua

module("logic.extensions.originashlessdragon.agent.OriginAshlessDragonAgent", package.seeall)

local OriginAshlessDragonAgent = class("OriginAshlessDragonAgent", BaseAgent)

function OriginAshlessDragonAgent:sendPM_OriginAshlessDragonGetInfoReq(activityId)
	local req = OriginAshlessDragonExtension_pb.PM_OriginAshlessDragonGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAshlessDragonAgent:handlePM_OriginAshlessDragonGetInfoRes(status, msg)
	if status == 0 then
		OriginAshlessDragonController.instance:handlePM_OriginAshlessDragonGetInfoRes(msg)
	end
end

function OriginAshlessDragonAgent:sendPM_OriginAshlessDragonChallengeReq(activityId, phaseId, stageId, form_pb, investBudget)
	local req = OriginAshlessDragonExtension_pb.PM_OriginAshlessDragonChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.investBudget = investBudget

	self:sendMsg(req)
end

function OriginAshlessDragonAgent:handlePM_OriginAshlessDragonChallengeRes(status, msg)
	if status == 0 then
		OriginAshlessDragonController.instance:handlePM_OriginAshlessDragonChallengeRes(msg)
	end
end

function OriginAshlessDragonAgent:sendPM_OriginAshlessDragonConfirmReq(activityId, phaseId, stageId, save)
	local req = OriginAshlessDragonExtension_pb.PM_OriginAshlessDragonConfirmReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginAshlessDragonAgent:handlePM_OriginAshlessDragonConfirmRes(status, msg)
	OriginAshlessDragonController.instance:handlePM_OriginAshlessDragonConfirmRes(status, msg)
end

function OriginAshlessDragonAgent:sendPM_OriginAshlessDragonResetReq(activityId, phaseId)
	local req = OriginAshlessDragonExtension_pb.PM_OriginAshlessDragonResetReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function OriginAshlessDragonAgent:handlePM_OriginAshlessDragonResetRes(status, msg)
	if status == 0 then
		OriginAshlessDragonController.instance:handlePM_OriginAshlessDragonResetRes(msg)
	end
end

function OriginAshlessDragonAgent:handlePM_Notify_OriginAshlessDragonChallengeEndRes(status, msg)
	if status == 0 then
		OriginAshlessDragonController.instance:handlePM_Notify_OriginAshlessDragonChallengeEndRes(msg)
	end
end

OriginAshlessDragonAgent.instance = OriginAshlessDragonAgent.New()

return OriginAshlessDragonAgent
