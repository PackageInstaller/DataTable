-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkLayerViewContainer", package.seeall)

local WeekWalkLayerViewContainer = class("WeekWalkLayerViewContainer", BaseViewContainer)

function WeekWalkLayerViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, WeekWalkLayerView.New())

	return views
end

function WeekWalkLayerViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.WeekWalk)

	return {
		self._navigateButtonView
	}
end

function WeekWalkLayerViewContainer:getNavBtnView()
	return self._navigateButtonView
end

return WeekWalkLayerViewContainer
