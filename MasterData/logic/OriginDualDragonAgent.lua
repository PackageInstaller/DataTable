-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/agent/OriginDualDragonAgent.lua

module("logic.extensions.origindualdragon.agent.OriginDualDragonAgent", package.seeall)

local OriginDualDragonAgent = class("OriginDualDragonAgent", BaseAgent)

function OriginDualDragonAgent:sendPM_OriginDualDragonInfoReq(activityId)
	local req = OriginDualDragonExtension_pb.PM_OriginDualDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDualDragonAgent:handlePM_OriginDualDragonInfoRes(status, msg)
	if status == 0 then
		OriginDualDragonController.instance:handlePM_OriginDualDragonInfoRes(msg)
	end
end

function OriginDualDragonAgent:sendPM_OriginDualDragonChallengeReq(activityId, form, stageType, stageId)
	local req = OriginDualDragonExtension_pb.PM_OriginDualDragonChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.stageType = stageType
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDualDragonAgent:handlePM_OriginDualDragonChallengeRes(status, msg)
	if status == 0 then
		OriginDualDragonController.instance:handlePM_OriginDualDragonChallengeRes(msg)
	end
end

function OriginDualDragonAgent:handlePM_OriginDualDragonNotifyChallengeRes(status, msg)
	if status == 0 then
		OriginDualDragonController.instance:handlePM_OriginDualDragonNotifyChallengeRes(msg)
	end
end

function OriginDualDragonAgent:sendPM_OriginDualDragonResetStageReq(activityId, stageId)
	local req = OriginDualDragonExtension_pb.PM_OriginDualDragonResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDualDragonAgent:handlePM_OriginDualDragonResetStageRes(status, msg)
	if status == 0 then
		OriginDualDragonController.instance:handlePM_OriginDualDragonResetStageRes(msg)
	end
end

OriginDualDragonAgent.instance = OriginDualDragonAgent.New()

return OriginDualDragonAgent
