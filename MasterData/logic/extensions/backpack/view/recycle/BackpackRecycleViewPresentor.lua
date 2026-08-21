-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/recycle/BackpackRecycleViewPresentor.lua

module("logic.extensions.backpack.view.recycle.BackpackRecycleViewPresentor", package.seeall)

local M = class("BackpackRecycleViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_backpack_recycle_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BackpackRecycleView.New())

	return views
end

return M
