-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RoguePropTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RoguePropTipsViewPresentor", package.seeall)

local M = class("RoguePropTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_props_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoguePropTipsView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
