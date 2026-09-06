-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/agent/DivineJieShenClgAgent.lua

module("logic.extensions.divinejieshenclg.agent.DivineJieShenClgAgent", package.seeall)

local DivineJieShenClgAgent = class("DivineJieShenClgAgent", BaseAgent)

function DivineJieShenClgAgent:sendPM_DivineJieShenClgGetInfoReq(activityId)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgGetInfoRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_DivineJieShenClgGetInfoRes(msg)
	end
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgExtremeChallengeReq(activityId, towerId, stageId, leftOrRight, form)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgExtremeChallengeReq()

	req.activityId = activityId
	req.towerId = towerId
	req.stageId = stageId
	req.leftOrRight = leftOrRight

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgExtremeChallengeRes(status, msg)
	DivineJieShenController.instance:handlePM_DivineJieShenClgExtremeChallengeRes(status, msg)
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgResetExtremeStageReq(activityId, leftOrRight)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgResetExtremeStageReq()

	req.activityId = activityId
	req.leftOrRight = leftOrRight

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgResetExtremeStageRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_DivineJieShenClgResetExtremeStageRes(msg)
	end
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgNormalRandomTrialReq(activityId, stageId, drawTimes)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgNormalRandomTrialReq()

	req.activityId = activityId
	req.stageId = stageId
	req.drawTimes = drawTimes

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgNormalRandomTrialRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	end
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgNormalStartGameReq(activityId, stageId, trialId, clientKey)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgNormalStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.trialId = trialId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgNormalStartGameRes(status, msg)
	DivineJieShenController.instance:handlePM_DivineJieShenClgNormalStartGameRes(status, msg)
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgNormalFinishGameReq(activityId, pass, score, encryptedKey)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgNormalFinishGameReq()

	req.activityId = activityId
	req.pass = pass
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgNormalFinishGameRes(status, msg)
	DivineJieShenController.instance:handlePM_DivineJieShenClgNormalFinishGameRes(status, msg)
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgNormalChallengeStageReq(activityId, stageId, form)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgNormalChallengeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgNormalChallengeStageRes(status, msg)
	DivineJieShenController.instance:handlePM_DivineJieShenClgNormalChallengeStageRes(status, msg)
end

function DivineJieShenClgAgent:sendPM_DivineJieShenClgNormalChallengeBossReq(activityId, form)
	local req = DivineJieShenClgExtension_pb.PM_DivineJieShenClgNormalChallengeBossReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineJieShenClgAgent:handlePM_DivineJieShenClgNormalChallengeBossRes(status, msg)
	DivineJieShenController.instance:handlePM_DivineJieShenClgNormalChallengeBossRes(status, msg)
end

function DivineJieShenClgAgent:handlePM_Notify_DivineJieShenClgExtremeChallengeEndRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_Notify_DivineJieShenClgExtremeChallengeEndRes(msg)
	end
end

function DivineJieShenClgAgent:handlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes(msg)
	end
end

function DivineJieShenClgAgent:handlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes(status, msg)
	if status == 0 then
		DivineJieShenController.instance:handlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes(msg)
	end
end

DivineJieShenClgAgent.instance = DivineJieShenClgAgent.New()

return DivineJieShenClgAgent
