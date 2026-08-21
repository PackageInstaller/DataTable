-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/currencyexchange/view/CurrencyExchangeTipsViewPresentor.lua

module("logic.extensions.currencyexchange.view.CurrencyExchangeTipsViewPresentor", package.seeall)

local M = class("CurrencyExchangeTipsViewPresentor", ViewPresentor)

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

	table.insert(views, CurrencyExchangeTipsView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyMoneyShowType))

	self._blurView = BlurBgView.New("common_blur_rt")

	table.insert(views, self._blurView)

	return views
end

function M:getBlurView()
	return self._blurView
end

return M
