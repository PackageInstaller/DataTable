-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreShoppingTipsViewPresentor.lua

module("logic.extensions.store.view.StoreShoppingTipsViewPresentor", package.seeall)

local M = class("StoreShoppingTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_store_shopping_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoreShoppingTipsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.StoreShoppingTipsViewPresentor)
end

return M
