-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeConditionFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeConditionFilterViewPresentor", package.seeall)

local HolyStripeConditionFilterViewPresentor = class("HolyStripeConditionFilterViewPresentor", ViewPresentor)

function HolyStripeConditionFilterViewPresentor:ctor()
	HolyStripeConditionFilterViewPresentor.super.ctor(self)
end

function HolyStripeConditionFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeConditionFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripelevelfitlerview.prefab"
	}
end

function HolyStripeConditionFilterViewPresentor:buildViews()
	return {
		HolyStripeConditionFilterView.New()
	}
end

function HolyStripeConditionFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeConditionFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeConditionFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeConditionFilterViewPresentor
