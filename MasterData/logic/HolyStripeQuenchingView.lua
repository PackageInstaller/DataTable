-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuenchingView.lua

module("logic.extensions.holystripe.view.HolyStripeQuenchingView", package.seeall)

local HolyStripeQuenchingView = class("HolyStripeQuenchingView", HolyStripeBagView)

function HolyStripeQuenchingView:buildUI()
	HolyStripeQuenchingView.super.buildUI(self)
end

function HolyStripeQuenchingView:bindEvents()
	HolyStripeQuenchingView.super.bindEvents(self)
end

function HolyStripeQuenchingView:unbindEvents()
	HolyStripeQuenchingView.super.unbindEvents(self)
end

return HolyStripeQuenchingView
