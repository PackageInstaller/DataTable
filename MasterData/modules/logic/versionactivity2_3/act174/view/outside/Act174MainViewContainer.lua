-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174MainViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174MainViewContainer", package.seeall)

local Act174MainViewContainer = class("Act174MainViewContainer", BaseViewContainer)

function Act174MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174MainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act174MainViewContainer:buildTabViews(tabContainerId)
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

return Act174MainViewContainer
