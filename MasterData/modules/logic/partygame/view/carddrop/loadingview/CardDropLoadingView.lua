-- chunkname: @modules/logic/partygame/view/carddrop/loadingview/CardDropLoadingView.lua

module("modules.logic.partygame.view.carddrop.loadingview.CardDropLoadingView", package.seeall)

local CardDropLoadingView = class("CardDropLoadingView", BaseView)

function CardDropLoadingView:onInitView()
	self.txtTitle = gohelper.findChildText(self.viewGO, "root/titlebg/#txt_title")
end

function CardDropLoadingView:onOpen()
	self.txtTitle.text = CardDropGameController.instance:getTitleText()
end

return CardDropLoadingView
