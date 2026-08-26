-- chunkname: @modules/logic/turnback/view/new/view/TurnbackReviewViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackReviewViewContainer", package.seeall)

local TurnbackReviewViewContainer = class("TurnbackReviewViewContainer", BaseViewContainer)

function TurnbackReviewViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackReviewView.New())

	return views
end

return TurnbackReviewViewContainer
