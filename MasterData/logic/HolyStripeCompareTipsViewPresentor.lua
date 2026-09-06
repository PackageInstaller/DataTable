-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeCompareTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeCompareTipsViewPresentor", package.seeall)

local HolyStripeCompareTipsViewPresentor = class("HolyStripeCompareTipsViewPresentor", ViewPresentor)

function HolyStripeCompareTipsViewPresentor:ctor()
	HolyStripeCompareTipsViewPresentor.super.ctor(self)
end

function HolyStripeCompareTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeCompareTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripecomparetipview.prefab"
	}
end

function HolyStripeCompareTipsViewPresentor:buildViews()
	return {
		HolyStripeCompareTipsView.New()
	}
end

function HolyStripeCompareTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeCompareTipsViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeCompareTipsViewPresentor
