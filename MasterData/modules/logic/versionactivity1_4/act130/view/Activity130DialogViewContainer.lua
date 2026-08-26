-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130DialogViewContainer.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130DialogViewContainer", package.seeall)

local Activity130DialogViewContainer = class("Activity130DialogViewContainer", BaseViewContainer)

function Activity130DialogViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity130DialogView.New())
	table.insert(views, TabViewGroup.New(1, "#go_bottomcontent/top_left"))

	return views
end

function Activity130DialogViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function Activity130DialogViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return Activity130DialogViewContainer
