-- chunkname: @modules/logic/weekwalk/view/WeekWalkDialogViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkDialogViewContainer", package.seeall)

local WeekWalkDialogViewContainer = class("WeekWalkDialogViewContainer", BaseViewContainer)

function WeekWalkDialogViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalkDialogView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function WeekWalkDialogViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function WeekWalkDialogViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return WeekWalkDialogViewContainer
