-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9RetailViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9RetailViewContainer", package.seeall)

local Season123_1_9RetailViewContainer = class("Season123_1_9RetailViewContainer", BaseViewContainer)

function Season123_1_9RetailViewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9RetailView.New(),
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function Season123_1_9RetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return self:buildCurrency()
	end
end

function Season123_1_9RetailViewContainer:buildCurrency()
	self._currencyView = CurrencyView.New({}, nil, nil, nil, true)
	self._currencyView.foreHideBtn = true

	return {
		self._currencyView
	}
end

function Season123_1_9RetailViewContainer:refreshCurrencyType()
	if self._currencyView then
		local actId = Season123RetailModel.instance.activityId
		local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)

		self._currencyView:setCurrencyType({
			ticketId
		})
	end
end

return Season123_1_9RetailViewContainer
