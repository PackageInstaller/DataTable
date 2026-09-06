-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxHighLuckTipView.lua

module("logic.extensions.giftbox.view.GiftBoxHighLuckTipView", package.seeall)

local GiftBoxHighLuckTipView = class("GiftBoxHighLuckTipView", ViewComponent)

function GiftBoxHighLuckTipView:ctor()
	GiftBoxHighLuckTipView.super.ctor(self)
end

function GiftBoxHighLuckTipView:unbindEvents()
	GiftBoxHighLuckTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GiftBoxHighLuckTipView:bindEvents()
	GiftBoxHighLuckTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxHighLuckTipView:buildUI()
	GiftBoxHighLuckTipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function GiftBoxHighLuckTipView:onExit()
	GiftBoxHighLuckTipView.super.onExit(self)
end

function GiftBoxHighLuckTipView:onEnter()
	GiftBoxHighLuckTipView.super.onEnter(self)
	GlobalDispatcher:dispatch(GlobalNotify.GiftBoxFirstShare)
end

return GiftBoxHighLuckTipView
