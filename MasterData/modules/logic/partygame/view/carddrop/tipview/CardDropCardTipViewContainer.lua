-- chunkname: @modules/logic/partygame/view/carddrop/tipview/CardDropCardTipViewContainer.lua

module("modules.logic.partygame.view.carddrop.tipview.CardDropCardTipViewContainer", package.seeall)

local CardDropCardTipViewContainer = class("CardDropCardTipViewContainer", BaseViewContainer)

function CardDropCardTipViewContainer:buildViews()
	return {
		CardDropCardTipView.New()
	}
end

return CardDropCardTipViewContainer
