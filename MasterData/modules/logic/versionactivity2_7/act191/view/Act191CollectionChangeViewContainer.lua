-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionChangeViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionChangeViewContainer", package.seeall)

local Act191CollectionChangeViewContainer = class("Act191CollectionChangeViewContainer", BaseViewContainer)

function Act191CollectionChangeViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CollectionChangeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191CollectionChangeViewContainer:buildTabViews()
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return Act191CollectionChangeViewContainer
