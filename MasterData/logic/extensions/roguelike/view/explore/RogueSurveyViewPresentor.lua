-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSurveyViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueSurveyViewPresentor", package.seeall)

local M = class("RogueSurveyViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_run_group_survey_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueSurveyView.New())

	return views
end

return M
