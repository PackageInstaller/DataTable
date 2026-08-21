-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/HealthExchangeTipsViewPresentor.lua

module("logic.extensions.healthexchange.HealthExchangeTipsViewPresentor", package.seeall)

local M = class("HealthExchangeTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Dialog_health_exchange_tips,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HealthExchangeTipsView.New())

	self._moneyView = MoneyView.New(CommEnum.MoneyShowType.DefaultHideType)

	table.insert(views, self._moneyView)
	table.insert(views, BlurBgView.New())

	return views
end

function M:getMoneyView()
	return self._moneyView
end

return M
