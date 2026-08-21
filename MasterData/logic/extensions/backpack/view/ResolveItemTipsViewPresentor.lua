-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/ResolveItemTipsViewPresentor.lua

module("logic.extensions.backpack.view.ResolveItemTipsViewPresentor", package.seeall)

local M = class("ResolveItemTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_resolve_item_hint_tips,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ResolveItemTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
