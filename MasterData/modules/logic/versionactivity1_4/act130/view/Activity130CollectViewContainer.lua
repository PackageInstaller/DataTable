-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130CollectViewContainer.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130CollectViewContainer", package.seeall)

local Activity130CollectViewContainer = class("Activity130CollectViewContainer", BaseViewContainer)

function Activity130CollectViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity130CollectView.New())

	return views
end

function Activity130CollectViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

return Activity130CollectViewContainer
