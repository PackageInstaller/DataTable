-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionConditionSortViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionConditionSortViewPresentor", package.seeall)

local HolyStripeQuickActionConditionSortViewPresentor = class("HolyStripeQuickActionConditionSortViewPresentor", ViewPresentor)

function HolyStripeQuickActionConditionSortViewPresentor:ctor()
	HolyStripeQuickActionConditionSortViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionConditionSortViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionConditionSortViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripeconditionview.prefab"
	}
end

function HolyStripeQuickActionConditionSortViewPresentor:buildViews()
	return {
		HolyStripeQuickActionConditionSortView.New()
	}
end

function HolyStripeQuickActionConditionSortViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionConditionSortViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQuickActionConditionSortViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQuickActionConditionSortViewPresentor
