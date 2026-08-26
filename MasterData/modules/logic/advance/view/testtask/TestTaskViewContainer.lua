-- chunkname: @modules/logic/advance/view/testtask/TestTaskViewContainer.lua

module("modules.logic.advance.view.testtask.TestTaskViewContainer", package.seeall)

local TestTaskViewContainer = class("TestTaskViewContainer", BaseViewContainer)

function TestTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, TestTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function TestTaskViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateButtonView
	}
end

return TestTaskViewContainer
