-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessTaskViewContainer.lua

module("modules.logic.activity.view.chessmap.Activity109ChessTaskViewContainer", package.seeall)

local Activity109ChessTaskViewContainer = class("Activity109ChessTaskViewContainer", BaseViewContainer)

function Activity109ChessTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity109ChessTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity109ChessTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Activity109ChessTaskViewContainer
