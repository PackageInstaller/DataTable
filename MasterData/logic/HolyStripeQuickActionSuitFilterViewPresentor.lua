-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionSuitFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionSuitFilterViewPresentor", package.seeall)

local HolyStripeQuickActionSuitFilterViewPresentor = class("HolyStripeQuickActionSuitFilterViewPresentor", ViewPresentor)

function HolyStripeQuickActionSuitFilterViewPresentor:ctor()
	HolyStripeQuickActionSuitFilterViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionSuitFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionSuitFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuitfilterview.prefab"
	}
end

function HolyStripeQuickActionSuitFilterViewPresentor:buildViews()
	return {
		HolyStripeQuickActionSuitFilterView.New()
	}
end

function HolyStripeQuickActionSuitFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionSuitFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQuickActionSuitFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQuickActionSuitFilterViewPresentor
