-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/config/SurveyConfig.lua

module("logic.extensions.survey.config.SurveyConfig", package.seeall)

local M = class("SurveyConfig", BaseConfig)

function M:ctor()
	self._cfgSurvey = nil
	self._cfgSurveySubject = nil
end

function M:getNames()
	return {
		ConfigName.Survey,
		ConfigName.SurveySubject
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Survey then
		self._cfgSurvey = content
	elseif name == ConfigName.SurveySubject then
		self._cfgSurveySubject = content
	end
end

function M:getSurveyCO(code)
	return self._cfgSurvey[code]
end

function M:getSubjectCfg(surveyId, subjectId)
	return self._cfgSurveySubject[surveyId][subjectId]
end

function M:getSubjectCfgById(surveyId)
	return self._cfgSurveySubject[surveyId]
end

M.instance = M.New()

return M
