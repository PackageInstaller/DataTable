-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreTipView.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreTipView", package.seeall)

local HolyStripeExploreTipView = class("HolyStripeExploreTipView", ViewComponent)

function HolyStripeExploreTipView:ctor()
	HolyStripeExploreTipView.super.ctor(self)
end

function HolyStripeExploreTipView:unbindEvents()
	HolyStripeExploreTipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function HolyStripeExploreTipView:bindEvents()
	HolyStripeExploreTipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function HolyStripeExploreTipView:onExit()
	HolyStripeExploreTipView.super.onExit(self)
end

function HolyStripeExploreTipView:buildUI()
	HolyStripeExploreTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function HolyStripeExploreTipView:onEnter()
	HolyStripeExploreTipView.super.onEnter(self)
end

return HolyStripeExploreTipView
