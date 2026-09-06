-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxTaskChildView.lua

module("logic.extensions.giftbox.view.GiftBoxTaskChildView", package.seeall)

local GiftBoxTaskChildView = class("GiftBoxTaskChildView", EventTaskTabChildView)

function GiftBoxTaskChildView:ctor()
	GiftBoxTaskChildView.super.ctor(self)
end

function GiftBoxTaskChildView:unbindEvents()
	GiftBoxTaskChildView.super.unbindEvents(self)
end

function GiftBoxTaskChildView:bindEvents()
	GiftBoxTaskChildView.super.bindEvents(self)
end

function GiftBoxTaskChildView:buildUI()
	GiftBoxTaskChildView.super.buildUI(self)
end

function GiftBoxTaskChildView:onExit()
	GiftBoxTaskChildView.super.onExit(self)
end

function GiftBoxTaskChildView:onEnter()
	GiftBoxTaskChildView.super.onEnter(self)
end

return GiftBoxTaskChildView
