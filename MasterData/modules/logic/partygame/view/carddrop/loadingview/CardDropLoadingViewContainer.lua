-- chunkname: @modules/logic/partygame/view/carddrop/loadingview/CardDropLoadingViewContainer.lua

module("modules.logic.partygame.view.carddrop.loadingview.CardDropLoadingViewContainer", package.seeall)

local CardDropLoadingViewContainer = class("CardDropLoadingViewContainer", BaseViewContainer)

function CardDropLoadingViewContainer:buildViews()
	return {
		CardDropLoadingView.New()
	}
end

return CardDropLoadingViewContainer
