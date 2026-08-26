-- chunkname: @modules/logic/act236/view/Act236MainViewContainer.lua

module("modules.logic.act236.view.Act236MainViewContainer", package.seeall)

local Act236MainViewContainer = class("Act236MainViewContainer", BaseViewContainer)

function Act236MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Act236MainView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function Act236MainViewContainer:buildTabViews(tabContainerId)
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

return Act236MainViewContainer
