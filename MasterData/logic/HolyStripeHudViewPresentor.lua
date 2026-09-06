-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripehud/view/HolyStripeHudViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeHudViewPresentor", package.seeall)

local HolyStripeHudViewPresentor = class("HolyStripeHudViewPresentor", ViewPresentor)

function HolyStripeHudViewPresentor:ctor()
	HolyStripeHudViewPresentor.super.ctor(self)
end

function HolyStripeHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeHudViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripehudview.prefab"
	}
end

function HolyStripeHudViewPresentor:buildViews()
	return {
		HolyStripeHudView.New()
	}
end

function HolyStripeHudViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeHudViewPresentor
