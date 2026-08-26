-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewRecommendViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewRecommendViewContainer", package.seeall)

local TurnbackNewRecommendViewContainer = class("TurnbackNewRecommendViewContainer", BaseViewContainer)

function TurnbackNewRecommendViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewRecommendView.New())

	return views
end

return TurnbackNewRecommendViewContainer
