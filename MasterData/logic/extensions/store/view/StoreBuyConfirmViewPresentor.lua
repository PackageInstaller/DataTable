-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreBuyConfirmViewPresentor.lua

module("logic.extensions.store.view.StoreBuyConfirmViewPresentor", package.seeall)

local M = class("StoreBuyConfirmViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_store_buy_confirm_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	self._mainView = StoreBuyConfirmView.New()

	table.insert(views, self._mainView)
	table.insert(views, BlurBgView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	return views
end

function M:onClickOutside()
	return
end

return M
