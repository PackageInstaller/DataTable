-- chunkname: @modules/logic/currency/view/CurrencyDiamondExchangeViewContainer.lua

module("modules.logic.currency.view.CurrencyDiamondExchangeViewContainer", package.seeall)

local CurrencyDiamondExchangeViewContainer = class("CurrencyDiamondExchangeViewContainer", BaseViewContainer)

function CurrencyDiamondExchangeViewContainer:buildViews()
	return {
		CurrencyDiamondExchangeView.New(),
		TabViewGroup.New(1, "#go_righttop")
	}
end

function CurrencyDiamondExchangeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return self:_buildCurrency()
	end
end

function CurrencyDiamondExchangeViewContainer:_buildCurrency()
	self._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon
	}, nil, nil, nil, true)

	return {
		self._currencyView
	}
end

return CurrencyDiamondExchangeViewContainer
