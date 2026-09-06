-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSmeltViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSmeltViewPresentor", package.seeall)

local HolyStripeSmeltViewPresentor = class("HolyStripeSmeltViewPresentor", ViewPresentor)

function HolyStripeSmeltViewPresentor:ctor()
	HolyStripeSmeltViewPresentor.super.ctor(self)
end

function HolyStripeSmeltViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeSmeltViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripestrengthview.prefab"
	}
end

function HolyStripeSmeltViewPresentor:buildViews()
	return {
		HolyStripeSmeltView.New()
	}
end

function HolyStripeSmeltViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSmeltViewPresentor
