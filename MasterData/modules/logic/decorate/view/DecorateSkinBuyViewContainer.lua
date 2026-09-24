-- chunkname: @modules/logic/decorate/view/DecorateSkinBuyViewContainer.lua

module("modules.logic.decorate.view.DecorateSkinBuyViewContainer", package.seeall)

local DecorateSkinBuyViewContainer = class("DecorateSkinBuyViewContainer", BaseViewContainer)

function DecorateSkinBuyViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, DecorateSkinBuyView.New())

	return views
end

function DecorateSkinBuyViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function DecorateSkinBuyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function DecorateSkinBuyViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return DecorateSkinBuyViewContainer
