-- chunkname: @modules/logic/store/view/StoreSkinGoodsView2Container.lua

module("modules.logic.store.view.StoreSkinGoodsView2Container", package.seeall)

local StoreSkinGoodsView2Container = class("StoreSkinGoodsView2Container", BaseViewContainer)

function StoreSkinGoodsView2Container:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, StoreSkinGoodsView2.New())

	return views
end

function StoreSkinGoodsView2Container:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function StoreSkinGoodsView2Container:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function StoreSkinGoodsView2Container:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return StoreSkinGoodsView2Container
