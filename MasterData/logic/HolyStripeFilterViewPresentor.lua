-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeFilterViewPresentor", package.seeall)

local HolyStripeFilterViewPresentor = class("HolyStripeFilterViewPresentor", ViewPresentor)

function HolyStripeFilterViewPresentor:ctor()
	HolyStripeFilterViewPresentor.super.ctor(self)
end

function HolyStripeFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripefilterview.prefab"
	}
end

function HolyStripeFilterViewPresentor:buildViews()
	return {
		HolyStripeFilterView.New()
	}
end

return HolyStripeFilterViewPresentor
