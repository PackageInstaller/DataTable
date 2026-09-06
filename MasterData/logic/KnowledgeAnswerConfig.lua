-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/config/KnowledgeAnswerConfig.lua

module("logic.extensions.knowledgeanswer.config.KnowledgeAnswerConfig", package.seeall)

local KnowledgeAnswerConfig = class("KnowledgeAnswerConfig", BaseConfig)

function KnowledgeAnswerConfig:getNames()
	return {
		"knowledge_answer_question",
		"knowledge_answer_seek_help",
		"knowledge_answer_activity",
		"knowledge_answer_score_prize"
	}
end

function KnowledgeAnswerConfig:handleConfig(name, content)
	if name == "knowledge_answer_question" then
		self._knowledge_answer_question = content
	elseif name == "knowledge_answer_seek_help" then
		self._knowledge_answer_seek_help = content
	elseif name == "knowledge_answer_activity" then
		self._knowledge_answer_activity = content
	elseif name == "knowledge_answer_score_prize" then
		self._knowledge_answer_score_prize = content
	end
end

function KnowledgeAnswerConfig:getActivityCfgById(activityId)
	return self._knowledge_answer_activity[activityId]
end

function KnowledgeAnswerConfig:getQuestionCfgById(activityId, questionId)
	return self._knowledge_answer_question[activityId][questionId]
end

function KnowledgeAnswerConfig:getPrizeCfgs(activityId)
	return self._knowledge_answer_score_prize[activityId]
end

function KnowledgeAnswerConfig:getHelpCfgByType(activityId, type)
	return self._knowledge_answer_seek_help[activityId][type]
end

KnowledgeAnswerConfig.instance = KnowledgeAnswerConfig.New()

return KnowledgeAnswerConfig
