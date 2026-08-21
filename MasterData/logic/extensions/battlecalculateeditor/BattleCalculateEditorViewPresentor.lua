-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/BattleCalculateEditorViewPresentor.lua

module("logic.extensions.battlecalculateeditor.BattleCalculateEditorViewPresentor", package.seeall)

local M = class("BattleCalculateEditorViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Battle_calculate_editor_main
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Hud
end

function M:buildViews()
	local views = {}

	table.insert(views, BattleCalculateEditorView.New())

	return views
end

return M
