-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191StoreViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191StoreViewContainer", package.seeall)

local Act191StoreViewContainer = class("Act191StoreViewContainer", BaseViewContainer)

function Act191StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191StoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191StoreViewContainer:buildTabViews(tabContainerId)
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

return Act191StoreViewContainer
