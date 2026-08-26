-- chunkname: @modules/logic/store/view/StoreSkinGoodsViewContainer.lua

module("modules.logic.store.view.StoreSkinGoodsViewContainer", package.seeall)

local StoreSkinGoodsViewContainer = class("StoreSkinGoodsViewContainer", BaseViewContainer)

function StoreSkinGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, StoreSkinGoodsView.New())

	return views
end

function StoreSkinGoodsViewContainer:buildTabViews(tabContainerId)
	self._currencyView = CurrencyView.New({})

	return {
		self._currencyView
	}
end

function StoreSkinGoodsViewContainer:setCurrencyType(list)
	if self._currencyView then
		self._currencyView:setCurrencyType(list)
	end
end

function StoreSkinGoodsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return StoreSkinGoodsViewContainer
