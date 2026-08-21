-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEncounterMainViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEncounterMainViewPresentor", package.seeall)

local M = class("RogueEncounterMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupjudgement_run_group_emergency_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEncounterMainView.New())

	return views
end

return M
