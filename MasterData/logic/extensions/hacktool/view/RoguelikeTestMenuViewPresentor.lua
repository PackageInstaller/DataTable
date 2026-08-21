-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/RoguelikeTestMenuViewPresentor.lua

module("logic.extensions.hacktool.view.RoguelikeTestMenuViewPresentor", package.seeall)

local M = class("RoguelikeTestMenuViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_roguelike_test_menu_panel
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoguelikeTestMenuView.New())

	return views
end

return M
