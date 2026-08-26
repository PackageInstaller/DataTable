-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191StageViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191StageViewContainer", package.seeall)

local Act191StageViewContainer = class("Act191StageViewContainer", BaseViewContainer)

function Act191StageViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191StageView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191StageViewContainer:buildTabViews(tabContainerId)
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

return Act191StageViewContainer
