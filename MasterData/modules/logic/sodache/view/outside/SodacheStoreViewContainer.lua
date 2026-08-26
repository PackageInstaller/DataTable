-- chunkname: @modules/logic/sodache/view/outside/SodacheStoreViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheStoreViewContainer", package.seeall)

local SodacheStoreViewContainer = class("SodacheStoreViewContainer", BaseViewContainer)

function SodacheStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheStoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function SodacheStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Sodache
		})
		self.currencyView.foreHideBtn = true

		return {
			self.currencyView
		}
	end
end

return SodacheStoreViewContainer
