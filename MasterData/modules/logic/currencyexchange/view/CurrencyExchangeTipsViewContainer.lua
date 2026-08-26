-- chunkname: @modules/logic/currencyexchange/view/CurrencyExchangeTipsViewContainer.lua

module("modules.logic.currencyexchange.view.CurrencyExchangeTipsViewContainer", package.seeall)

local CurrencyExchangeTipsViewContainer = class("CurrencyExchangeTipsViewContainer", BaseViewContainer)

function CurrencyExchangeTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, CurrencyExchangeTipsView.New())

	return views
end

return CurrencyExchangeTipsViewContainer
