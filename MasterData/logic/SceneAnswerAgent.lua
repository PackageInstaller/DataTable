-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/agent/SceneAnswerAgent.lua

module("logic.extensions.answerscene.agent.SceneAnswerAgent", package.seeall)

local SceneAnswerAgent = class("SceneAnswerAgent", BaseAgent)

function SceneAnswerAgent:sendPM_SceneAnswerInfoReq()
	local req = SceneAnswerExtension_pb.PM_SceneAnswerInfoReq()

	self:sendMsg(req)
end

function SceneAnswerAgent:handlePM_SceneAnswerInfoRes(status, msg)
	forcePrint("SceneAnswerAgent.handlePM_SceneAnswerInfoRes===", status)

	if status == 0 then
		AnswerSceneController.instance:onAnswerSceneInfo(msg)
	end
end

function SceneAnswerAgent:sendPM_SceneAnswerReq(questionId, optionId)
	local req = SceneAnswerExtension_pb.PM_SceneAnswerReq()

	req.questionId = questionId
	req.optionId = optionId

	self:sendMsg(req)
end

function SceneAnswerAgent:handlePM_SceneAnswerRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SceneAnswerAgent:sendPM_SceneAnswerGainScorePrizeReq()
	local req = SceneAnswerExtension_pb.PM_SceneAnswerGainScorePrizeReq()

	self:sendMsg(req)
end

function SceneAnswerAgent:handlePM_SceneAnswerGainScorePrizeRes(status, msg)
	if status == 0 then
		AnswerSceneController.instance:onSceneAnswerGainScorePrize(msg)
	end
end

function SceneAnswerAgent:handlePM_NotifyNewQuestionRes(status, msg)
	if status == 0 then
		AnswerSceneController.instance:onNewQuestion(msg)
	end
end

function SceneAnswerAgent:sendPM_SceneAnswerSeekHelpReq(type)
	local req = SceneAnswerExtension_pb.PM_SceneAnswerSeekHelpReq()

	req.type = type

	self:sendMsg(req)
end

function SceneAnswerAgent:handlePM_SceneAnswerSeekHelpRes(status, msg)
	if status == 0 then
		AnswerSceneController.instance:onAskForHelper()
	end
end

function SceneAnswerAgent:handlePM_NotifyQuestionResult(status, msg)
	if status == 0 then
		AnswerSceneController.instance:onAnswerQuestion(msg)
	end
end

SceneAnswerAgent.instance = SceneAnswerAgent.New()

return SceneAnswerAgent
