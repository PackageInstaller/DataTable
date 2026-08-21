-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/RewardPreviewViewPresentor.lua

module("logic.extensions.dungeon.view.RewardPreviewViewPresentor", package.seeall)

local M = class("RewardPreviewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Branchline_settle_details_view,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RewardPreviewView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
