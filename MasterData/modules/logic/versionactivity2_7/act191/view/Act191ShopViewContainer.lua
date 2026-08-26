-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191ShopViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191ShopViewContainer", package.seeall)

local Act191ShopViewContainer = class("Act191ShopViewContainer", BaseViewContainer)

function Act191ShopViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191ShopView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191ShopViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Act191ShopViewContainer
