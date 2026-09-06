-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/agent/RelationPowerAgent.lua

module("logic.extensions.relationpower.agent.RelationPowerAgent", package.seeall)

local RelationPowerAgent = class("RelationPowerAgent", BaseAgent)

function RelationPowerAgent:sendPM_RelationPowerGetInfoReq(activityId)
	local req = RelationPowerExtension_pb.PM_RelationPowerGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RelationPowerAgent:handlePM_RelationPowerGetInfoRes(status, msg)
	if status == 0 then
		RelationPowerController.instance:handleGetInfo(msg)
	else
		RelationPowerController.instance:_onError(status)
	end
end

function RelationPowerAgent:sendPM_RelationPowerVerifyReq(activityId, formId, form)
	local req = RelationPowerExtension_pb.PM_RelationPowerVerifyReq()

	req.activityId = activityId
	req.formId = formId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function RelationPowerAgent:handlePM_RelationPowerVerifyRes(status, msg)
	if status == 0 then
		RelationPowerController.instance:handleVerifyPower(msg)
	else
		RelationPowerController.instance:_onError(status)
	end
end

function RelationPowerAgent:sendPM_RelationPowerGainTaskPrizeReq(activityId, taskId)
	local req = RelationPowerExtension_pb.PM_RelationPowerGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function RelationPowerAgent:handlePM_RelationPowerGainTaskPrizeRes(status, msg)
	if status == 0 then
		RelationPowerController.instance:handleGainPrize(msg)
	else
		RelationPowerController.instance:_onError(status)
	end
end

RelationPowerAgent.instance = RelationPowerAgent.New()

return RelationPowerAgent
