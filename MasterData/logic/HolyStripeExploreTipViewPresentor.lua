-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreTipViewPresentor.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreTipViewPresentor", package.seeall)

local HolyStripeExploreTipViewPresentor = class("HolyStripeExploreTipViewPresentor", ViewPresentor)

function HolyStripeExploreTipViewPresentor:ctor()
	HolyStripeExploreTipViewPresentor.super.ctor(self)
end

function HolyStripeExploreTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeExploreTipViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripeexplore/holystripeexploretipview.prefab"
	}
end

function HolyStripeExploreTipViewPresentor:buildViews()
	return {
		HolyStripeExploreTipView.New()
	}
end

return HolyStripeExploreTipViewPresentor
