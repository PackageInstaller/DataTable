-- chunkname: @modules/logic/partygame/view/carddrop/CardDropStartGameViewContainer.lua

module("modules.logic.partygame.view.carddrop.CardDropStartGameViewContainer", package.seeall)

local CardDropStartGameViewContainer = class("CardDropStartGameViewContainer", BaseViewContainer)

function CardDropStartGameViewContainer:buildViews()
	return {
		CardDropStartGameView.New()
	}
end

return CardDropStartGameViewContainer
