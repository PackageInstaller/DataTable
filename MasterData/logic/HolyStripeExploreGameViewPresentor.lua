-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/view/HolyStripeExploreGameViewPresentor.lua

module("logic.extensions.holystripeexplore.view.HolyStripeExploreGameViewPresentor", package.seeall)

local HolyStripeExploreGameViewPresentor = class("HolyStripeExploreGameViewPresentor", ViewPresentor)

function HolyStripeExploreGameViewPresentor:ctor()
	HolyStripeExploreGameViewPresentor.super.ctor(self)
end

function HolyStripeExploreGameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeExploreGameViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripeexplore/holystripeexploregameview.prefab"
	}
end

function HolyStripeExploreGameViewPresentor:buildViews()
	return {
		HolyStripeExploreGameView.New()
	}
end

return HolyStripeExploreGameViewPresentor
