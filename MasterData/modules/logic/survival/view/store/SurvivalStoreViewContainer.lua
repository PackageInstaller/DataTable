-- chunkname: @modules/logic/survival/view/store/SurvivalStoreViewContainer.lua

module("modules.logic.survival.view.store.SurvivalStoreViewContainer", package.seeall)

local SurvivalStoreViewContainer = class("SurvivalStoreViewContainer", BaseViewContainer)

function SurvivalStoreViewContainer:buildViews()
	return {
		SurvivalStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function SurvivalStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		self._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.SurvivalCurrency
		})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

return SurvivalStoreViewContainer
