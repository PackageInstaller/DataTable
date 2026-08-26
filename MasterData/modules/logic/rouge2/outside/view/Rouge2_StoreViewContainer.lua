-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_StoreViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_StoreViewContainer", package.seeall)

local Rouge2_StoreViewContainer = class("Rouge2_StoreViewContainer", BaseViewContainer)

function Rouge2_StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_StoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop"))

	return views
end

function Rouge2_StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end

	if tabContainerId == 2 then
		self._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V3a2Rouge
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		return {
			self._currencyView
		}
	end
end

function Rouge2_StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

return Rouge2_StoreViewContainer
