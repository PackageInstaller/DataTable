-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_StoreViewContainer.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreViewContainer", package.seeall)

local V1a6_BossRush_StoreViewContainer = class("V1a6_BossRush_StoreViewContainer", BaseViewContainer)

function V1a6_BossRush_StoreViewContainer:buildViews()
	return {
		V1a6_BossRush_StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function V1a6_BossRush_StoreViewContainer:buildTabViews(tabContainerId)
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
			CurrencyEnum.CurrencyType.BossRushStore
		}, self._onCurrencyCallback, self)
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function V1a6_BossRush_StoreViewContainer:_onCurrencyCallback()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnHandleInStoreView)
end

return V1a6_BossRush_StoreViewContainer
