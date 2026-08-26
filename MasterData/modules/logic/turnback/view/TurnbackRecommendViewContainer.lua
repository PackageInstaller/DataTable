-- chunkname: @modules/logic/turnback/view/TurnbackRecommendViewContainer.lua

module("modules.logic.turnback.view.TurnbackRecommendViewContainer", package.seeall)

local TurnbackRecommendViewContainer = class("TurnbackRecommendViewContainer", BaseViewContainer)

function TurnbackRecommendViewContainer:buildViews()
	return {
		TurnbackRecommendView.New()
	}
end

return TurnbackRecommendViewContainer
