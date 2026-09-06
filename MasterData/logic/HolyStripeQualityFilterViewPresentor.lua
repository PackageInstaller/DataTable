-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQualityFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQualityFilterViewPresentor", package.seeall)

local HolyStripeQualityFilterViewPresentor = class("HolyStripeQualityFilterViewPresentor", ViewPresentor)

function HolyStripeQualityFilterViewPresentor:ctor()
	HolyStripeQualityFilterViewPresentor.super.ctor(self)
end

function HolyStripeQualityFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQualityFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripequailtyfitlerview.prefab"
	}
end

function HolyStripeQualityFilterViewPresentor:buildViews()
	return {
		HolyStripeQualityFilterView.New()
	}
end

function HolyStripeQualityFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQualityFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQualityFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQualityFilterViewPresentor
