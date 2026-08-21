-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRolePropConfirmViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueRolePropConfirmViewPresentor", package.seeall)

local M = class("RogueRolePropConfirmViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupexplore_props_use_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueRolePropConfirmView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
