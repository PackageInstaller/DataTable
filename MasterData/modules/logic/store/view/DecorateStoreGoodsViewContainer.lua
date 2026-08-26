-- chunkname: @modules/logic/store/view/DecorateStoreGoodsViewContainer.lua

module("modules.logic.store.view.DecorateStoreGoodsViewContainer", package.seeall)

local DecorateStoreGoodsViewContainer = class("DecorateStoreGoodsViewContainer", BaseViewContainer)

function DecorateStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, DecorateStoreGoodsView.New())

	return views
end

function DecorateStoreGoodsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function DecorateStoreGoodsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function DecorateStoreGoodsViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return DecorateStoreGoodsViewContainer
