-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewShowRewardViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardViewContainer", package.seeall)

local TurnbackNewShowRewardViewContainer = class("TurnbackNewShowRewardViewContainer", BaseViewContainer)

function TurnbackNewShowRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewShowRewardView.New())

	return views
end

return TurnbackNewShowRewardViewContainer
