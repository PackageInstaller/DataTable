-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuenchingViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuenchingViewPresentor", package.seeall)

local HolyStripeQuenchingViewPresentor = class("HolyStripeQuenchingViewPresentor", ViewPresentor)

function HolyStripeQuenchingViewPresentor:ctor()
	HolyStripeQuenchingViewPresentor.super.ctor(self)
end

function HolyStripeQuenchingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeQuenchingViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripebagview.prefab"
	}
end

function HolyStripeQuenchingViewPresentor:buildViews()
	return {
		HolyStripeQuenchingView.New()
	}
end

function HolyStripeQuenchingViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeQuenchingViewPresentor
