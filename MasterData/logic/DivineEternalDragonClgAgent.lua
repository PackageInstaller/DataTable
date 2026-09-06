-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/agent/DivineEternalDragonClgAgent.lua

module("logic.extensions.divineeternaldragonclg.agent.DivineEternalDragonClgAgent", package.seeall)

local DivineEternalDragonClgAgent = class("DivineEternalDragonClgAgent", BaseAgent)

function DivineEternalDragonClgAgent:sendPM_DivineEternalDragonClgGetInfoReq(activityId)
	local req = DivineEternalDragonClgExtension_pb.PM_DivineEternalDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineEternalDragonClgAgent:handlePM_DivineEternalDragonClgGetInfoRes(status, msg)
	if status == 0 then
		DivineEternalDragonClgController.instance:handleGetInfo(msg)
	end
end

function DivineEternalDragonClgAgent:sendPM_DivineEternalDragonClgChallengeReq(activityId, stageId, teamId, form_pb)
	local req = DivineEternalDragonClgExtension_pb.PM_DivineEternalDragonClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineEternalDragonClgAgent:handlePM_DivineEternalDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineEternalDragonClgAgent:sendPM_DivineEternalDragonClgResetStageReq(activityId, stageId)
	local req = DivineEternalDragonClgExtension_pb.PM_DivineEternalDragonClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineEternalDragonClgAgent:handlePM_DivineEternalDragonClgResetStageRes(status, msg)
	if status == 0 then
		DivineEternalDragonClgController.instance:handleResetStage(msg)
	end
end

function DivineEternalDragonClgAgent:handlePM_Notify_DivineEternalDragonClgChallengeEndRes(status, msg)
	if status == 0 then
		DivineEternalDragonClgController.instance:handleChallengeEnd(msg)
	end
end

DivineEternalDragonClgAgent.instance = DivineEternalDragonClgAgent.New()

return DivineEternalDragonClgAgent
