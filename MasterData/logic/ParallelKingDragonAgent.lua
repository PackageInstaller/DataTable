-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/agent/ParallelKingDragonAgent.lua

module("logic.extensions.parallelkingdragon.agent.ParallelKingDragonAgent", package.seeall)

local ParallelKingDragonAgent = class("ParallelKingDragonAgent", BaseAgent)

function ParallelKingDragonAgent:sendPM_ParallelKingDragonInfoReq(activityId)
	local req = ParallelKingDragonExtension_pb.PM_ParallelKingDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ParallelKingDragonAgent:handlePM_ParallelKingDragonInfoRes(status, msg)
	if status == 0 then
		ParallelkingdragonModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ParallelKingDragonInfoRes)
	end
end

function ParallelKingDragonAgent:sendPM_ParallelKingDragonChallengeReq(activityId, form, stageId)
	local req = ParallelKingDragonExtension_pb.PM_ParallelKingDragonChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.stageId = stageId

	self:sendMsg(req)
end

function ParallelKingDragonAgent:handlePM_ParallelKingDragonChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ParallelKingDragonChallengeRes)
	end
end

function ParallelKingDragonAgent:handlePM_ParallelKingDragonNotifyChallengeRes(status, msg)
	if status == 0 then
		ParallelkingdragonController.instance:onNotifyChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ParallelKingDragonNotifyChallengeRes)
	end
end

ParallelKingDragonAgent.instance = ParallelKingDragonAgent.New()

return ParallelKingDragonAgent
