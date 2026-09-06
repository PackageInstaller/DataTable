-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeRapaceTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeRapaceTipsViewPresentor", package.seeall)

local HolyStripeRapaceTipsViewPresentor = class("HolyStripeRapaceTipsViewPresentor", ViewPresentor)

function HolyStripeRapaceTipsViewPresentor:ctor()
	HolyStripeRapaceTipsViewPresentor.super.ctor(self)
end

function HolyStripeRapaceTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeRapaceTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystriperepacetipsview.prefab"
	}
end

function HolyStripeRapaceTipsViewPresentor:buildViews()
	return {
		HolyStripeRapaceTipsView.New()
	}
end

function HolyStripeRapaceTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeRapaceTipsViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeRapaceTipsViewPresentor
