-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSimpleTipViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSimpleTipViewPresentor", package.seeall)

local HolyStripeSimpleTipViewPresentor = class("HolyStripeSimpleTipViewPresentor", ViewPresentor)

function HolyStripeSimpleTipViewPresentor:ctor()
	HolyStripeSimpleTipViewPresentor.super.ctor(self)
end

function HolyStripeSimpleTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function HolyStripeSimpleTipViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesimpletipview.prefab"
	}
end

function HolyStripeSimpleTipViewPresentor:buildViews()
	return {
		HolyStripeSimpleTipView.New()
	}
end

function HolyStripeSimpleTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSimpleTipViewPresentor
