-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/newview/ClimbingTowerEntryViewPresentor.lua

module("logic.extensions.climbingtower.view.newview.ClimbingTowerEntryViewPresentor", package.seeall)

local M = class("ClimbingTowerEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Climbing_tower_explore_climbing_tower_enetry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClimbingTowerEntryView.New())
	table.insert(views, ClimbingTowerBrightView.New())
	table.insert(views, ClimbingTowerDarkView.New())

	return views
end

return M
