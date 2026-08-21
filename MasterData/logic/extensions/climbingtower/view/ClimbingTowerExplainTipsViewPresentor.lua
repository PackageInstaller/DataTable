-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerExplainTipsViewPresentor.lua

module("logic.extensions.climbingtower.view.ClimbingTowerExplainTipsViewPresentor", package.seeall)

local M = class("ClimbingTowerExplainTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Climbing_tower_explore_climbing_tower_explan_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ClimbingTowerExplainTipsView.New())

	return views
end

return M
