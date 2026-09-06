-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeRecommendCalcViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeRecommendCalcViewPresentor", package.seeall)

local HolyStripeRecommendCalcViewPresentor = class("HolyStripeRecommendCalcViewPresentor", ViewPresentor)

function HolyStripeRecommendCalcViewPresentor:ctor()
	HolyStripeRecommendCalcViewPresentor.super.ctor(self)
end

function HolyStripeRecommendCalcViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeRecommendCalcViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystriperecommendcalcview.prefab"
	}
end

function HolyStripeRecommendCalcViewPresentor:buildViews()
	return {
		HolyStripeRecommendCalcView.New()
	}
end

return HolyStripeRecommendCalcViewPresentor
