-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderShopViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderShopViewPresentor", package.seeall)

local ExploreUnderShopViewPresentor = class("ExploreUnderShopViewPresentor", ViewPresentor)

function ExploreUnderShopViewPresentor:ctor()
	ExploreUnderShopViewPresentor.super.ctor(self)
end

function ExploreUnderShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderShopViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundershopview.prefab"
	}
end

function ExploreUnderShopViewPresentor:buildViews()
	return {
		ExploreUnderShopView.New()
	}
end

return ExploreUnderShopViewPresentor
