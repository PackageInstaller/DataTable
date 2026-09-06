-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionQualityFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionQualityFilterViewPresentor", package.seeall)

local HolyStripeQuickActionQualityFilterViewPresentor = class("HolyStripeQuickActionQualityFilterViewPresentor", ViewPresentor)

function HolyStripeQuickActionQualityFilterViewPresentor:ctor()
	HolyStripeQuickActionQualityFilterViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionQualityFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionQualityFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripequailtyfitlerview.prefab"
	}
end

function HolyStripeQuickActionQualityFilterViewPresentor:buildViews()
	return {
		HolyStripeQuickActionQualityFilterView.New()
	}
end

function HolyStripeQuickActionQualityFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionQualityFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQuickActionQualityFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQuickActionQualityFilterViewPresentor
