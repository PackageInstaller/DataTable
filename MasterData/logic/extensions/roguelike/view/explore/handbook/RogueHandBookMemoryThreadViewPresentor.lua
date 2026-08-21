-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMemoryThreadViewPresentor.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMemoryThreadViewPresentor", package.seeall)

local M = class("RogueHandBookMemoryThreadViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungrouphandbook_run_group_handbook_thread_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHandBookMemoryThreadView.New())

	local blurView = BlurBgView.New()

	blurView:OnlyBlurScene()
	table.insert(views, blurView)

	return views
end

return M
