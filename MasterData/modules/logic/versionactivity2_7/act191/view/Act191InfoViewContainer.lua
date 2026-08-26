-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191InfoViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191InfoViewContainer", package.seeall)

local Act191InfoViewContainer = class("Act191InfoViewContainer", BaseViewContainer)

function Act191InfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191InfoView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191InfoViewContainer:buildTabViews(tabContainerId)
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

return Act191InfoViewContainer
