-- chunkname: @modules/logic/partygame/view/carddrop/resultview/CardDropResultViewContainer.lua

module("modules.logic.partygame.view.carddrop.resultview.CardDropResultViewContainer", package.seeall)

local CardDropResultViewContainer = class("CardDropResultViewContainer", BaseViewContainer)

function CardDropResultViewContainer:buildViews()
	return {
		CardDropResultView.New()
	}
end

return CardDropResultViewContainer
