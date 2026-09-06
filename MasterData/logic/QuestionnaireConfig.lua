-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/config/QuestionnaireConfig.lua

module("logic.extensions.questionnaire.config.QuestionnaireConfig", package.seeall)

local QuestionnaireConfig = class("QuestionnaireConfig", BaseConfig)

function QuestionnaireConfig:onInit()
	QuestionnaireConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function QuestionnaireConfig:getNames()
	return {
		"survey_question",
		"survey_answer_plan",
		"survey_answer",
		"survey_define",
		"questionnaire_constants"
	}
end

function QuestionnaireConfig:handleConfig(name, content)
	if name == "survey_question" then
		self._questionCfg = content
	elseif name == "survey_answer_plan" then
		self._planCfg = content
	elseif name == "survey_answer" then
		self._answerCfg = content
	elseif name == "survey_define" then
		self._defineCfg = content
	elseif name == "questionnaire_constants" then
		self._longhuang_common = content
	end
end

function QuestionnaireConfig:getConstantValue(key)
	local cfg = self._longhuang_common[key]

	if cfg then
		return cfg.value
	end
end

function QuestionnaireConfig:getQuestionCfgsById(surveyId)
	local cfgs = {}

	for _, v in ipairs(self._questionCfg.dataList) do
		if v.surveyId == surveyId then
			table.insert(cfgs, v)
		end
	end

	table.sort(cfgs, function(a, b)
		return a.questionId < b.questionId
	end)

	return cfgs
end

function QuestionnaireConfig:getSurveyCfgs()
	return self._defineCfg.dataList
end

function QuestionnaireConfig:getPrizeCfgById(surveyId)
	if self._defineCfg then
		return self._defineCfg[surveyId]
	end
end

function QuestionnaireConfig:getPlanCfgsById(planId)
	local cfgs = {}

	if self._planCfg then
		for _, v in ipairs(self._planCfg.dataList) do
			if v.planId == planId then
				table.insert(cfgs, v)
			end
		end
	end

	table.sort(cfgs, function(a, b)
		return a.id < b.id
	end)

	return cfgs
end

function QuestionnaireConfig:getOptionCfgsById(optionId)
	local cfgs = {}

	if self._answerCfg then
		for _, v in ipairs(self._answerCfg.dataList) do
			if v.optionId == optionId then
				table.insert(cfgs, v)
			end
		end
	end

	table.sort(cfgs, function(a, b)
		return a.id < b.id
	end)

	return cfgs
end

QuestionnaireConfig.instance = QuestionnaireConfig.New()

return QuestionnaireConfig
