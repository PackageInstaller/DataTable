-- chunkname: @modules/logic/partygame/view/decision/DecisionGameViewContainer.lua

module("modules.logic.partygame.view.decision.DecisionGameViewContainer", package.seeall)

local DecisionGameViewContainer = class("DecisionGameViewContainer", SceneGameCommonViewContainer)

function DecisionGameViewContainer:getGameView()
	return {
		DecisionGameView.New()
	}
end

return DecisionGameViewContainer
