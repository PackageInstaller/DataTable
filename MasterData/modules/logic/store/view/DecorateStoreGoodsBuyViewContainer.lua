-- chunkname: @modules/logic/store/view/DecorateStoreGoodsBuyViewContainer.lua

module("modules.logic.store.view.DecorateStoreGoodsBuyViewContainer", package.seeall)

local DecorateStoreGoodsBuyViewContainer = class("DecorateStoreGoodsBuyViewContainer", BaseViewContainer)

function DecorateStoreGoodsBuyViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateStoreGoodsBuyView.New())

	return views
end

function DecorateStoreGoodsBuyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function DecorateStoreGoodsBuyViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return DecorateStoreGoodsBuyViewContainer
