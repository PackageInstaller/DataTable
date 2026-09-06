-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/questionnaire/model/QuestionnaireModel.lua

module("logic.extensions.questionnaire.model.QuestionnaireModel", package.seeall)

local QuestionnaireModel = class("QuestionnaireModel", BaseModel)

function QuestionnaireModel:onInit()
	self:onReset()
end

function QuestionnaireModel:onReset()
	self._serverMsgGeted = false

	print("QuestionnaireModel onReset")

	self._surveyDic = {}

	local cfgs = QuestionnaireConfig.instance:getSurveyCfgs()

	for _, v in ipairs(cfgs) do
		local survey = {}

		survey.surveyId = v.surveyId
		survey.gainGift = false
		survey.done = false
		self._surveyDic[v.surveyId] = survey
	end
end

function QuestionnaireModel:ctor()
	return
end

function QuestionnaireModel:getSurveyDone(surveyId)
	local survey = self._surveyDic[surveyId]

	return survey and survey.done == true
end

function QuestionnaireModel:getSurveyGainGift(surveyId)
	local survey = self._surveyDic[surveyId]

	return survey and survey.gainGift == true
end

function QuestionnaireModel:setSurveyDone(surveyId)
	local survey = self._surveyDic[surveyId]

	if survey then
		survey.done = true
	end
end

function QuestionnaireModel:setSurveyGainGift(surveyId)
	local survey = self._surveyDic[surveyId]

	if survey then
		survey.gainGift = true
	end
end

function QuestionnaireModel:getSurveyId()
	if not self._serverMsgGeted then
		return -1
	end

	for k, v in pairs(self._surveyDic) do
		if v.gainGift ~= true then
			local cfg = ActivityDefineConfig.instance:getCfgById(11, k)

			if cfg and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
				return k
			end
		end
	end

	return -1
end

function QuestionnaireModel:onServerMsg(msg)
	self._serverMsgGeted = true

	for _, v in ipairs(msg.surveys) do
		self._surveyDic[v.surveyId] = v
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMainUIFuncs)
end

QuestionnaireModel.instance = QuestionnaireModel.New()

return QuestionnaireModel
