-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessMapListViewContainer.lua

module("modules.logic.activity.view.chessmap.Activity109ChessMapListViewContainer", package.seeall)

local Activity109ChessMapListViewContainer = class("Activity109ChessMapListViewContainer", BaseViewContainer)

function Activity109ChessMapListViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity109ChessMapListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity109ChessMapListViewContainer:buildTabViews(tabContainerId)
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

return Activity109ChessMapListViewContainer
