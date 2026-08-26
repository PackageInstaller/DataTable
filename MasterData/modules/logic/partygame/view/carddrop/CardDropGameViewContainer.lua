-- chunkname: @modules/logic/partygame/view/carddrop/CardDropGameViewContainer.lua

module("modules.logic.partygame.view.carddrop.CardDropGameViewContainer", package.seeall)

local CardDropGameViewContainer = class("CardDropGameViewContainer", SceneGameCommonViewContainer)

function CardDropGameViewContainer:getGameView()
	return {
		CardDropStateLogicView.New(),
		CardDropTimeView.New(),
		CardDropGameView.New(),
		CardDropGameCardView.New(),
		CardDropHpView.New()
	}
end

return CardDropGameViewContainer
