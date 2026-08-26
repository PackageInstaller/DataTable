-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191InitBuildViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildViewContainer", package.seeall)

local Act191InitBuildViewContainer = class("Act191InitBuildViewContainer", BaseViewContainer)

function Act191InitBuildViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191InitBuildView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191InitBuildViewContainer:buildTabViews(tabContainerId)
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

return Act191InitBuildViewContainer
