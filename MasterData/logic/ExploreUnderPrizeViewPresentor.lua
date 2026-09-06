-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderPrizeViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderPrizeViewPresentor", package.seeall)

local ExploreUnderPrizeViewPresentor = class("ExploreUnderPrizeViewPresentor", ViewPresentor)

function ExploreUnderPrizeViewPresentor:ctor()
	ExploreUnderPrizeViewPresentor.super.ctor(self)
end

function ExploreUnderPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreunderprizeview.prefab"
	}
end

function ExploreUnderPrizeViewPresentor:buildViews()
	return {
		ExploreUnderPrizeView.New()
	}
end

return ExploreUnderPrizeViewPresentor
