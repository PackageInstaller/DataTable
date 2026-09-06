-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxLowLuckTipView.lua

module("logic.extensions.giftbox.view.GiftBoxLowLuckTipView", package.seeall)

local GiftBoxLowLuckTipView = class("GiftBoxLowLuckTipView", ViewComponent)

function GiftBoxLowLuckTipView:ctor()
	GiftBoxLowLuckTipView.super.ctor(self)
end

function GiftBoxLowLuckTipView:unbindEvents()
	GiftBoxLowLuckTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GiftBoxLowLuckTipView:bindEvents()
	GiftBoxLowLuckTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxLowLuckTipView:buildUI()
	GiftBoxLowLuckTipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtScore = self:getTxt("txtScore")
end

function GiftBoxLowLuckTipView:onExit()
	GiftBoxLowLuckTipView.super.onExit(self)
end

function GiftBoxLowLuckTipView:onEnter()
	GiftBoxLowLuckTipView.super.onEnter(self)

	self._txtScore.text = langPara("当前欧气值：<color=#E8382FFF>%d</color>", checknumber(GiftBoxModel.instance:getScore()))
end

return GiftBoxLowLuckTipView
