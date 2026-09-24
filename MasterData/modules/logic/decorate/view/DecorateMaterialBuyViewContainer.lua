-- chunkname: @modules/logic/decorate/view/DecorateMaterialBuyViewContainer.lua

module("modules.logic.decorate.view.DecorateMaterialBuyViewContainer", package.seeall)

local DecorateMaterialBuyViewContainer = class("DecorateMaterialBuyViewContainer", BaseViewContainer)

function DecorateMaterialBuyViewContainer:buildViews()
	local views = {}

	table.insert(views, self:getBuyView())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function DecorateMaterialBuyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function DecorateMaterialBuyViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function DecorateMaterialBuyViewContainer:getBuyView()
	self._buyView = self._buyView or DecorateMaterialBuyView.New()

	return self._buyView
end

return DecorateMaterialBuyViewContainer
