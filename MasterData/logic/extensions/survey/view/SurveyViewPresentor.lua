-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/SurveyViewPresentor.lua

module("logic.extensions.survey.view.SurveyViewPresentor", package.seeall)

local M = class("SurveyViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Survey_survey_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SurveyHtmlView.New())

	return views
end

return M
