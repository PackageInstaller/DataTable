-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessGameClearContainer.lua

module("modules.logic.activity.view.chessmap.Activity109ChessGameClearContainer", package.seeall)

local Activity109ChessGameClearContainer = class("Activity109ChessGameClearContainer", BaseViewContainer)

function Activity109ChessGameClearContainer:buildViews()
	local views = {}

	table.insert(views, Activity109ChessGameClear.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity109ChessGameClearContainer:buildTabViews(tabContainerId)
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

return Activity109ChessGameClearContainer
