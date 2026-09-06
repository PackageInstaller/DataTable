-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionConditionFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionConditionFilterViewPresentor", package.seeall)

local HolyStripeQuickActionConditionFilterViewPresentor = class("HolyStripeQuickActionConditionFilterViewPresentor", ViewPresentor)

function HolyStripeQuickActionConditionFilterViewPresentor:ctor()
	HolyStripeQuickActionConditionFilterViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionConditionFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionConditionFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripelevelfitlerview.prefab"
	}
end

function HolyStripeQuickActionConditionFilterViewPresentor:buildViews()
	return {
		HolyStripeQuickActionConditionFilterView.New()
	}
end

function HolyStripeQuickActionConditionFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionConditionFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQuickActionConditionFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQuickActionConditionFilterViewPresentor
