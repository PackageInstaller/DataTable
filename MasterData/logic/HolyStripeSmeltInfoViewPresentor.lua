-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSmeltInfoViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSmeltInfoViewPresentor", package.seeall)

local HolyStripeSmeltInfoViewPresentor = class("HolyStripeSmeltInfoViewPresentor", ViewPresentor)

function HolyStripeSmeltInfoViewPresentor:ctor()
	HolyStripeSmeltInfoViewPresentor.super.ctor(self)
end

function HolyStripeSmeltInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSmeltInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesetview.prefab"
	}
end

function HolyStripeSmeltInfoViewPresentor:buildViews()
	return {
		HolyStripeSmeltInfoView.New()
	}
end

function HolyStripeSmeltInfoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeSmeltInfoViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeSmeltInfoViewPresentor
