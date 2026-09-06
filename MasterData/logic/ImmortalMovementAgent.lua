-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/agent/ImmortalMovementAgent.lua

module("logic.extensions.immortalmovement.agent.ImmortalMovementAgent", package.seeall)

local ImmortalMovementAgent = class("ImmortalMovementAgent", BaseAgent)

function ImmortalMovementAgent:sendPM_ImmortalMovementInfoReq(activityId)
	local req = ImmortalMovementExtension_pb.PM_ImmortalMovementInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ImmortalMovementAgent:handlePM_ImmortalMovementInfoRes(status, msg)
	if status == 0 then
		ImmortalMovementController.instance:handleGetInfo(msg)
	end
end

function ImmortalMovementAgent:sendPM_ImmortalMovementUnlockScoreReq(activityId, scoreId)
	local req = ImmortalMovementExtension_pb.PM_ImmortalMovementUnlockScoreReq()

	req.activityId = activityId
	req.scoreId = scoreId

	self:sendMsg(req)
end

function ImmortalMovementAgent:handlePM_ImmortalMovementUnlockScoreRes(status, msg)
	if status == 0 then
		ImmortalMovementController.instance:handleUnlockScore(msg)
	end
end

function ImmortalMovementAgent:sendPM_ImmortalMovementChallengeReq(activityId, form_pb, stageId)
	local req = ImmortalMovementExtension_pb.PM_ImmortalMovementChallengeReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function ImmortalMovementAgent:handlePM_ImmortalMovementChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ImmortalMovementAgent:handlePM_ImmortalMovementNotifyChallengeRes(status, msg)
	if status == 0 then
		ImmortalMovementController.instance:handleNotifyChallenge(msg)
	end
end

ImmortalMovementAgent.instance = ImmortalMovementAgent.New()

return ImmortalMovementAgent
