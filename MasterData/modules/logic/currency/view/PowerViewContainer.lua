-- chunkname: @modules/logic/currency/view/PowerViewContainer.lua

module("modules.logic.currency.view.PowerViewContainer", package.seeall)

local PowerViewContainer = class("PowerViewContainer", BaseViewContainer)

function PowerViewContainer:buildViews()
	local views = {}

	table.insert(views, PowerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))
	table.insert(views, TabViewGroup.New(2, "#go_lefttop"))

	return views
end

local openTransitionParam = {
	duration = 0.01
}

function PowerViewContainer:playOpenTransition()
	PowerViewContainer.super.playOpenTransition(self, openTransitionParam)
end

function PowerViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyType = CurrencyEnum.CurrencyType
		local currencyParam = {
			currencyType.Diamond,
			currencyType.FreeDiamondCoupon
		}

		return {
			CurrencyView.New(currencyParam)
		}
	elseif tabContainerId == 2 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Power)

		return {
			self.navigateView
		}
	end
end

return PowerViewContainer
