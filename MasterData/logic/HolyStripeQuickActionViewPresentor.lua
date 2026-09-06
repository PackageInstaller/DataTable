-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionViewPresentor", package.seeall)

local HolyStripeQuickActionViewPresentor = class("HolyStripeQuickActionViewPresentor", ViewPresentor)

function HolyStripeQuickActionViewPresentor:ctor()
	HolyStripeQuickActionViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripequickactionview.prefab"
	}
end

function HolyStripeQuickActionViewPresentor:buildViews()
	return {
		HolyStripeQuickActionView.New()
	}
end

function HolyStripeQuickActionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionViewPresentor:onClickOutside()
	return
end

return HolyStripeQuickActionViewPresentor
