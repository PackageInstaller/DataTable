-- chunkname: @modules/logic/store/view/PackageStoreGoodsViewContainer.lua

module("modules.logic.store.view.PackageStoreGoodsViewContainer", package.seeall)

local PackageStoreGoodsViewContainer = class("PackageStoreGoodsViewContainer", BaseViewContainer)

function PackageStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, PackageStoreGoodsView.New())

	return views
end

function PackageStoreGoodsViewContainer:buildTabViews(tabContainerId)
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

function PackageStoreGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return PackageStoreGoodsViewContainer
