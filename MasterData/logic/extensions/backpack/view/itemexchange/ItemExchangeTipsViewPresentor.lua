-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/itemexchange/ItemExchangeTipsViewPresentor.lua

module("logic.extensions.backpack.view.itemexchange.ItemExchangeTipsViewPresentor", package.seeall)

local M = class("ItemExchangeTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Common_common_exchange_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ItemExchangeTipsView.New())

	return views
end

return M
