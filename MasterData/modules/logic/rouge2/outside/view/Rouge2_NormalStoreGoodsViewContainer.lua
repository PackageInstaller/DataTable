-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_NormalStoreGoodsViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_NormalStoreGoodsViewContainer", package.seeall)

local Rouge2_NormalStoreGoodsViewContainer = class("Rouge2_NormalStoreGoodsViewContainer", BaseViewContainer)

function Rouge2_NormalStoreGoodsViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topright"),
		Rouge2_NormalStoreGoodsView.New()
	}
end

function Rouge2_NormalStoreGoodsViewContainer:buildTabViews(tabContainerId)
	local costId = CurrencyEnum.CurrencyType.V3a2Rouge

	self._currencyView = CurrencyView.New({
		costId
	})

	self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

	return {
		self._currencyView
	}
end

function Rouge2_NormalStoreGoodsViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function Rouge2_NormalStoreGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Rouge2_NormalStoreGoodsViewContainer
