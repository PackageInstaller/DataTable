-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeConditionSortViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeConditionSortViewPresentor", package.seeall)

local HolyStripeConditionSortViewPresentor = class("HolyStripeConditionSortViewPresentor", ViewPresentor)

function HolyStripeConditionSortViewPresentor:ctor()
	HolyStripeConditionSortViewPresentor.super.ctor(self)
end

function HolyStripeConditionSortViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeConditionSortViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripeconditionview.prefab"
	}
end

function HolyStripeConditionSortViewPresentor:buildViews()
	return {
		HolyStripeConditionSortView.New()
	}
end

function HolyStripeConditionSortViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeConditionSortViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeConditionSortViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeConditionSortViewPresentor
