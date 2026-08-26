-- chunkname: @modules/logic/messagebox/view/MessageBoxViewContainer.lua

module("modules.logic.messagebox.view.MessageBoxViewContainer", package.seeall)

local MessageBoxViewContainer = class("MessageBoxViewContainer", BaseViewContainer)

function MessageBoxViewContainer:buildViews()
	return {
		MessageBoxView.New(),
		TabViewGroup.New(1, "#go_topright")
	}
end

function MessageBoxViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function MessageBoxViewContainer:setCurrencyByParams(showCostParams)
	if self._currencyView then
		self._currencyView:setCurrencyType(showCostParams)
	end
end

return MessageBoxViewContainer
