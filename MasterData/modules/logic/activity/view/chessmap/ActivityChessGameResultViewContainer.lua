-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameResultViewContainer.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameResultViewContainer", package.seeall)

local ActivityChessGameResultViewContainer = class("ActivityChessGameResultViewContainer", BaseViewContainer)

function ActivityChessGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityChessGameResultView.New())

	return views
end

return ActivityChessGameResultViewContainer
