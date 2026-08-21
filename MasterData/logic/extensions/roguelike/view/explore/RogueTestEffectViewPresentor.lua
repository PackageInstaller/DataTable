-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueTestEffectViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueTestEffectViewPresentor", package.seeall)

local M = class("RogueTestEffectViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_props_test_effect_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueTestEffectView.New())

	return views
end

return M
