-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2ResetViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2ResetViewContainer", package.seeall)

local WeekWalk_2ResetViewContainer = class("WeekWalk_2ResetViewContainer", BaseViewContainer)

function WeekWalk_2ResetViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, WeekWalk_2ResetView.New())

	return views
end

function WeekWalk_2ResetViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.WeekWalkReset)

	return {
		self._navigateButtonView
	}
end

return WeekWalk_2ResetViewContainer
