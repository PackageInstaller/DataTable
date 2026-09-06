-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/agent/OriginTSDragonClgAgent.lua

module("logic.extensions.origintsdragonclg.agent.OriginTSDragonClgAgent", package.seeall)

local OriginTSDragonClgAgent = class("OriginTSDragonClgAgent", BaseAgent)

function OriginTSDragonClgAgent:sendPM_OriginTSDragonClgInfoReq(activityId)
	local req = OriginTSDragonClgExtension_pb.PM_OriginTSDragonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginTSDragonClgAgent:handlePM_OriginTSDragonClgInfoRes(status, msg)
	if status == 0 then
		OriginTSDragonClgController.instance:handlePM_OriginTSDragonClgInfoRes(msg)
	end
end

function OriginTSDragonClgAgent:sendPM_OriginTSDragonChallengeReq(activityId, phaseId, stageId, simpleForm, puzzleId)
	local req = OriginTSDragonClgExtension_pb.PM_OriginTSDragonChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if simpleForm then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	req.puzzleId = puzzleId

	self:sendMsg(req)
end

function OriginTSDragonClgAgent:handlePM_OriginTSDragonChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginTSDragonClgAgent:sendPM_OriginTSDragonConfirmReq(activityId, phaseId, stageId, save)
	local req = OriginTSDragonClgExtension_pb.PM_OriginTSDragonConfirmReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginTSDragonClgAgent:handlePM_OriginTSDragonConfirmRes(status, msg)
	if status == 0 then
		OriginTSDragonClgController.instance:handlePM_OriginTSDragonConfirmRes(msg)
	end
end

function OriginTSDragonClgAgent:sendPM_OriginTSDragonResetReq(activityId)
	local req = OriginTSDragonClgExtension_pb.PM_OriginTSDragonResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginTSDragonClgAgent:handlePM_OriginTSDragonResetRes(status, msg)
	if status == 0 then
		OriginTSDragonClgController.instance:handlePM_OriginTSDragonResetRes(msg)
	end
end

function OriginTSDragonClgAgent:handlePM_NotifyTSDragonChallengeFinishRes(status, msg)
	if status == 0 then
		OriginTSDragonClgController.instance:handlePM_NotifyTSDragonChallengeFinishRes(msg)
	end
end

OriginTSDragonClgAgent.instance = OriginTSDragonClgAgent.New()

return OriginTSDragonClgAgent
