-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameRewardViewContainer.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameRewardViewContainer", package.seeall)

local ActivityChessGameRewardViewContainer = class("ActivityChessGameRewardViewContainer", BaseViewContainer)

function ActivityChessGameRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityChessGameRewardView.New())

	return views
end

return ActivityChessGameRewardViewContainer
