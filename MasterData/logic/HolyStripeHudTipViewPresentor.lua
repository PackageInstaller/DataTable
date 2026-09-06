-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripehud/view/HolyStripeHudTipViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeHudTipViewPresentor", package.seeall)

local HolyStripeHudTipViewPresentor = class("HolyStripeHudTipViewPresentor", ViewPresentor)

function HolyStripeHudTipViewPresentor:ctor()
	HolyStripeHudTipViewPresentor.super.ctor(self)
end

function HolyStripeHudTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeHudTipViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystirpehudtipview.prefab"
	}
end

function HolyStripeHudTipViewPresentor:buildViews()
	return {
		HolyStripeHudTipView.New()
	}
end

function HolyStripeHudTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeHudTipViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeHudTipViewPresentor
