-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191AssistantViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191AssistantViewContainer", package.seeall)

local Act191AssistantViewContainer = class("Act191AssistantViewContainer", BaseViewContainer)

function Act191AssistantViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191AssistantView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191AssistantViewContainer:buildTabViews(tabContainerId)
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

return Act191AssistantViewContainer
