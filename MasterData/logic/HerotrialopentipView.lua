-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialopentipView.lua

module("logic.extensions.herotrial.view.HerotrialopentipView", package.seeall)

local HerotrialopentipView = class("HerotrialopentipView", ViewComponent)

function HerotrialopentipView:ctor()
	HerotrialopentipView.super.ctor(self)
end

function HerotrialopentipView:buildUI()
	HerotrialopentipView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
end

function HerotrialopentipView:bindEvents()
	HerotrialopentipView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
end

function HerotrialopentipView:unbindEvents()
	HerotrialopentipView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
end

function HerotrialopentipView:destroyUI()
	HerotrialopentipView.super.destroyUI(self)
end

function HerotrialopentipView:onEnter()
	HerotrialopentipView.super.onEnter(self)
end

function HerotrialopentipView:onEnterFinished()
	HerotrialopentipView.super.onEnterFinished(self)
end

function HerotrialopentipView:onExit()
	HerotrialopentipView.super.onExit(self)
end

function HerotrialopentipView:onExitFinished()
	HerotrialopentipView.super.onExitFinished(self)
end

return HerotrialopentipView
