-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackD6FilterViewPresentor.lua

module("logic.extensions.backpack.view.BackpackD6FilterViewPresentor", package.seeall)

local M = class("BackpackD6FilterViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_backpack_filter_tips_2
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BackpackD6FilterView.New())

	return views
end

return M
