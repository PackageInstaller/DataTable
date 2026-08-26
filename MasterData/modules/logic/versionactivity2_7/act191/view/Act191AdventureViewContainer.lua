-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191AdventureViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191AdventureViewContainer", package.seeall)

local Act191AdventureViewContainer = class("Act191AdventureViewContainer", BaseViewContainer)

function Act191AdventureViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191AdventureView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191AdventureViewContainer:buildTabViews(tabContainerId)
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

return Act191AdventureViewContainer
