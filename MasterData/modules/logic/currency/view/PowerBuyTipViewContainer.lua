-- chunkname: @modules/logic/currency/view/PowerBuyTipViewContainer.lua

module("modules.logic.currency.view.PowerBuyTipViewContainer", package.seeall)

local PowerBuyTipViewContainer = class("PowerBuyTipViewContainer", BaseViewContainer)

function PowerBuyTipViewContainer:buildViews()
	local views = {}

	table.insert(views, PowerBuyTipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function PowerBuyTipViewContainer:buildTabViews(tabContainerId)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.Diamond,
		currencyType.FreeDiamondCoupon
	}

	return {
		CurrencyView.New(currencyParam)
	}
end

return PowerBuyTipViewContainer
