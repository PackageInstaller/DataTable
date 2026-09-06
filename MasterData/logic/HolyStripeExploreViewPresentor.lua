-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreViewPresentor.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreViewPresentor", package.seeall)

local HolyStripeExploreViewPresentor = class("HolyStripeExploreViewPresentor", ViewPresentor)

function HolyStripeExploreViewPresentor:ctor()
	HolyStripeExploreViewPresentor.super.ctor(self)
end

function HolyStripeExploreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeExploreViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripeexplore/holystripeexploreview.prefab"
	}
end

function HolyStripeExploreViewPresentor:buildViews()
	return {
		HolyStripeExploreView.New()
	}
end

return HolyStripeExploreViewPresentor
