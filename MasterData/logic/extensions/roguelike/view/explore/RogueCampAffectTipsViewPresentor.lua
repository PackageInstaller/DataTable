-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueCampAffectTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueCampAffectTipsViewPresentor", package.seeall)

local M = class("RogueCampAffectTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_camp_affect_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueCampAffectTipsView.New())

	return views
end

return M
