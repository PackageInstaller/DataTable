-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderShopEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderShopEventViewPresentor", package.seeall)

local ExploreUnderShopEventViewPresentor = class("ExploreUnderShopEventViewPresentor", ViewPresentor)

function ExploreUnderShopEventViewPresentor:ctor()
	ExploreUnderShopEventViewPresentor.super.ctor(self)
end

function ExploreUnderShopEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderShopEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundershopeventview.prefab"
	}
end

function ExploreUnderShopEventViewPresentor:buildViews()
	return {
		ExploreUnderShopEventView.New()
	}
end

return ExploreUnderShopEventViewPresentor
