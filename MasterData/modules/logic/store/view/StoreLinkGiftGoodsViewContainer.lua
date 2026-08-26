-- chunkname: @modules/logic/store/view/StoreLinkGiftGoodsViewContainer.lua

module("modules.logic.store.view.StoreLinkGiftGoodsViewContainer", package.seeall)

local StoreLinkGiftGoodsViewContainer = class("StoreLinkGiftGoodsViewContainer", BaseViewContainer)

function StoreLinkGiftGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, StoreLinkGiftGoodsView.New())

	return views
end

function StoreLinkGiftGoodsViewContainer:buildTabViews(tabContainerId)
	self._currencyView = CurrencyView.New({})

	local currencyType = CurrencyEnum.CurrencyType

	self._currencyView:setCurrencyType({
		currencyType.Diamond,
		currencyType.FreeDiamondCoupon
	})

	return {
		self._currencyView
	}
end

function StoreLinkGiftGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return StoreLinkGiftGoodsViewContainer
