-- chunkname: @modules/logic/weekwalk/view/WeekWalkResetViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkResetViewContainer", package.seeall)

local WeekWalkResetViewContainer = class("WeekWalkResetViewContainer", BaseViewContainer)

function WeekWalkResetViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, WeekWalkResetView.New())

	return views
end

function WeekWalkResetViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.WeekWalkReset)

	return {
		self._navigateButtonView
	}
end

return WeekWalkResetViewContainer
