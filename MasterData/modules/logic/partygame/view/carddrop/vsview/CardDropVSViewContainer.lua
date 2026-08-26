-- chunkname: @modules/logic/partygame/view/carddrop/vsview/CardDropVSViewContainer.lua

module("modules.logic.partygame.view.carddrop.vsview.CardDropVSViewContainer", package.seeall)

local CardDropVSViewContainer = class("CardDropVSViewContainer", BaseViewContainer)

function CardDropVSViewContainer:buildViews()
	return {
		CardDropVSView.New()
	}
end

return CardDropVSViewContainer
