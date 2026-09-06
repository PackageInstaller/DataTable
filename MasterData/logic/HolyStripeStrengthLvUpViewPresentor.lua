-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeStrengthLvUpViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeStrengthLvUpViewPresentor", package.seeall)

local HolyStripeStrengthLvUpViewPresentor = class("HolyStripeStrengthLvUpViewPresentor", ViewPresentor)

function HolyStripeStrengthLvUpViewPresentor:ctor()
	HolyStripeStrengthLvUpViewPresentor.super.ctor(self)
end

function HolyStripeStrengthLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeStrengthLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripestrengthlvupview.prefab"
	}
end

function HolyStripeStrengthLvUpViewPresentor:buildViews()
	return {
		HolyStripeStrengthLvUpView.New()
	}
end

function HolyStripeStrengthLvUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeStrengthLvUpViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeStrengthLvUpViewPresentor
