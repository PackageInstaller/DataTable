-- chunkname: @modules/logic/partygame/view/carddrop/promotionview/CardDropPromotionViewContainer.lua

module("modules.logic.partygame.view.carddrop.promotionview.CardDropPromotionViewContainer", package.seeall)

local CardDropPromotionViewContainer = class("CardDropPromotionViewContainer", BaseViewContainer)

function CardDropPromotionViewContainer:buildViews()
	return {
		CardDropPromotionView.New()
	}
end

return CardDropPromotionViewContainer
