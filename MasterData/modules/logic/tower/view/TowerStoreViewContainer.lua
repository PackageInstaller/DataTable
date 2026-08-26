-- chunkname: @modules/logic/tower/view/TowerStoreViewContainer.lua

module("modules.logic.tower.view.TowerStoreViewContainer", package.seeall)

local TowerStoreViewContainer = class("TowerStoreViewContainer", BaseViewContainer)

function TowerStoreViewContainer:buildViews()
	return {
		TowerStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function TowerStoreViewContainer:buildTabViews(tabContainerId)
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
			CurrencyEnum.CurrencyType.TowerStore
		}, self._onCurrencyCallback, self)
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function TowerStoreViewContainer:_onCurrencyCallback()
	BossRushController.instance:dispatchEvent(TowerEvent.OnHandleInStoreView)
end

return TowerStoreViewContainer
