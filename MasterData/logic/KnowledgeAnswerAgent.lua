-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/agent/KnowledgeAnswerAgent.lua

module("logic.extensions.knowledgeanswer.agent.KnowledgeAnswerAgent", package.seeall)

local KnowledgeAnswerAgent = class("KnowledgeAnswerAgent", BaseAgent)

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerInfoReq(activityId)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerInfoRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleGetInfo(msg)
	end
end

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerReq(activityId, questionId, optionId)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerReq()

	req.activityId = activityId
	req.questionId = questionId
	req.optionId = optionId

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleSendAnswer(msg)
	end
end

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerGainScorePrizeReq(activityId, prizeId)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerGainScorePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerGainScorePrizeRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleGainPrize(msg)
	end
end

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerSeekHelpReq(activityId, type)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerSeekHelpReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerSeekHelpRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleSeekHelp(msg)
	end
end

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerJoinRoomReq(activityId)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerJoinRoomReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerJoinRoomRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleJoinRoom(msg)
	end
end

function KnowledgeAnswerAgent:sendPM_KnowledgeAnswerLeaveRoomReq(activityId)
	local req = KnowledgeAnswerExtension_pb.PM_KnowledgeAnswerLeaveRoomReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KnowledgeAnswerAgent:handlePM_KnowledgeAnswerLeaveRoomRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:handleLeaveRoom(msg)
	end
end

function KnowledgeAnswerAgent:handlePM_NotifyKnowledgeAnswerNewQuestionRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:notifyUpdateNewQuestion(msg)
	end
end

function KnowledgeAnswerAgent:handlePM_NotifyKnowledgeAnswerQuestionRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:notifyAnswerQuestion(msg)
	end
end

function KnowledgeAnswerAgent:handlePM_NotifyKnowledgeAnswerRoomMembersRes(status, msg)
	if status == 0 then
		KnowledgeAnswerController.instance:notifyUpdateRoomMembers(msg)
	end
end

KnowledgeAnswerAgent.instance = KnowledgeAnswerAgent.New()

return KnowledgeAnswerAgent
