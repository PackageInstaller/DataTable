-- chunkname: @modules/logic/activity/view/chessmap/Activity109ChessEntryContainer.lua

module("modules.logic.activity.view.chessmap.Activity109ChessEntryContainer", package.seeall)

local Activity109ChessEntryContainer = class("Activity109ChessEntryContainer", BaseViewContainer)

function Activity109ChessEntryContainer:buildViews()
	local views = {}

	table.insert(views, Activity109ChessEntry.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity109ChessEntryContainer:buildTabViews(tabContainerId)
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

function Activity109ChessEntryContainer:onContainerOpen()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act109)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act109
	})
end

return Activity109ChessEntryContainer
