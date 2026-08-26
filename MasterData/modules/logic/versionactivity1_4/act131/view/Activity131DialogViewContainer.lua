-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131DialogViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131DialogViewContainer", package.seeall)

local Activity131DialogViewContainer = class("Activity131DialogViewContainer", BaseViewContainer)

function Activity131DialogViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity131DialogView.New())
	table.insert(views, TabViewGroup.New(1, "#go_bottomcontent/top_left"))

	return views
end

function Activity131DialogViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function Activity131DialogViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return Activity131DialogViewContainer
