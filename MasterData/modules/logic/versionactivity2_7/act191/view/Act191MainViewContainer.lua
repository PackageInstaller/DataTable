-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191MainViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191MainViewContainer", package.seeall)

local Act191MainViewContainer = class("Act191MainViewContainer", BaseViewContainer)

function Act191MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191MainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191MainViewContainer:buildTabViews(tabContainerId)
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

return Act191MainViewContainer
