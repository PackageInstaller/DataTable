-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxTaskView.lua

module("logic.extensions.giftbox.view.GiftBoxTaskView", package.seeall)

local GiftBoxTaskView = class("GiftBoxTaskView", EventTaskTabFrameView)

function GiftBoxTaskView:ctor()
	GiftBoxTaskView.super.ctor(self)
end

function GiftBoxTaskView:unbindEvents()
	GiftBoxTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self.close, self)
end

function GiftBoxTaskView:bindEvents()
	GiftBoxTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GiftBoxTaskView:buildUI()
	GiftBoxTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
end

function GiftBoxTaskView:onExit()
	GiftBoxTaskView.super.onExit(self)
end

function GiftBoxTaskView:onEnter()
	GiftBoxTaskView.super.onEnter(self)
end

return GiftBoxTaskView
