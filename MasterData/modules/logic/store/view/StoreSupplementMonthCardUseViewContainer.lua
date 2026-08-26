-- chunkname: @modules/logic/store/view/StoreSupplementMonthCardUseViewContainer.lua

module("modules.logic.store.view.StoreSupplementMonthCardUseViewContainer", package.seeall)

local StoreSupplementMonthCardUseViewContainer = class("StoreSupplementMonthCardUseViewContainer", BaseViewContainer)

function StoreSupplementMonthCardUseViewContainer:buildViews()
	return {
		StoreSupplementMonthCardUseView.New(),
		TabViewGroup.New(1, "#go_topright")
	}
end

function StoreSupplementMonthCardUseViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function StoreSupplementMonthCardUseViewContainer:setCurrencyByParams(showCostParams)
	if self._currencyView then
		self._currencyView:setCurrencyType(showCostParams)
	end
end

return StoreSupplementMonthCardUseViewContainer
