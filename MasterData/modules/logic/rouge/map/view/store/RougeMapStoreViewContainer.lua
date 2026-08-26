-- chunkname: @modules/logic/rouge/map/view/store/RougeMapStoreViewContainer.lua

module("modules.logic.rouge.map.view.store.RougeMapStoreViewContainer", package.seeall)

local RougeMapStoreViewContainer = class("RougeMapStoreViewContainer", BaseViewContainer)

function RougeMapStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapStoreView.New())
	table.insert(views, RougeMapCoinView.New())

	return views
end

function RougeMapStoreViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	self.navigateView:setOverrideClose(RougeMapHelper.backToMainScene)

	return {
		self.navigateView
	}
end

return RougeMapStoreViewContainer
