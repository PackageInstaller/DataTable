-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionPosFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionPosFilterViewPresentor", package.seeall)

local HolyStripeQuickActionPosFilterViewPresentor = class("HolyStripeQuickActionPosFilterViewPresentor", ViewPresentor)

function HolyStripeQuickActionPosFilterViewPresentor:ctor()
	HolyStripeQuickActionPosFilterViewPresentor.super.ctor(self)
end

function HolyStripeQuickActionPosFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeQuickActionPosFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripeposlfitlerview.prefab"
	}
end

function HolyStripeQuickActionPosFilterViewPresentor:buildViews()
	return {
		HolyStripeQuickActionPosFilterView.New()
	}
end

function HolyStripeQuickActionPosFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeQuickActionPosFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeQuickActionPosFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeQuickActionPosFilterViewPresentor
