-- chunkname: @modules/logic/currency/view/CurrencyExchangeViewContainer.lua

module("modules.logic.currency.view.CurrencyExchangeViewContainer", package.seeall)

local CurrencyExchangeViewContainer = class("CurrencyExchangeViewContainer", BaseViewContainer)

function CurrencyExchangeViewContainer:buildViews()
	return {
		CurrencyExchangeView.New(),
		TabViewGroup.New(1, "#go_righttop")
	}
end

function CurrencyExchangeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return self:_buildCurrency()
	end
end

function CurrencyExchangeViewContainer:_buildCurrency()
	local currencyList = {}

	if self.viewParam and self.viewParam.costData then
		table.insert(currencyList, self.viewParam.costData)
	end

	table.insert(currencyList, CurrencyEnum.CurrencyType.Diamond)
	table.insert(currencyList, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	self._currencyView = CurrencyView.New(currencyList, nil, nil, nil, true)

	return {
		self._currencyView
	}
end

return CurrencyExchangeViewContainer
