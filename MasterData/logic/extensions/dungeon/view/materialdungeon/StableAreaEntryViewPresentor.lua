-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaEntryViewPresentor.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaEntryViewPresentor", package.seeall)

local M = class("StableAreaEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Resources_stable_area_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StableAreaEntryView.New())

	return views
end

return M
