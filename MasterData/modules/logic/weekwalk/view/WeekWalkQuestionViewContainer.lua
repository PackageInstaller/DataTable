-- chunkname: @modules/logic/weekwalk/view/WeekWalkQuestionViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkQuestionViewContainer", package.seeall)

local WeekWalkQuestionViewContainer = class("WeekWalkQuestionViewContainer", BaseViewContainer)

function WeekWalkQuestionViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalkQuestionView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function WeekWalkQuestionViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

function WeekWalkQuestionViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return WeekWalkQuestionViewContainer
