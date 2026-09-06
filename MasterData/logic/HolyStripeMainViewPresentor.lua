-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeMainViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeMainViewPresentor", package.seeall)

local HolyStripeMainViewPresentor = class("HolyStripeMainViewPresentor", ViewPresentor)

function HolyStripeMainViewPresentor:ctor()
	HolyStripeMainViewPresentor.super.ctor(self)
end

function HolyStripeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripemainview.prefab"
	}
end

function HolyStripeMainViewPresentor:buildViews()
	return {
		HolyStripeMainView.New()
	}
end

function HolyStripeMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeMainViewPresentor
