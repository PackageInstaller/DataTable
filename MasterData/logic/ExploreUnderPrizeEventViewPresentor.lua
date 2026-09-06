-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderPrizeEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderPrizeEventViewPresentor", package.seeall)

local ExploreUnderPrizeEventViewPresentor = class("ExploreUnderPrizeEventViewPresentor", ViewPresentor)

function ExploreUnderPrizeEventViewPresentor:ctor()
	ExploreUnderPrizeEventViewPresentor.super.ctor(self)
end

function ExploreUnderPrizeEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderPrizeEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreunderprizeeventview.prefab"
	}
end

function ExploreUnderPrizeEventViewPresentor:buildViews()
	return {
		ExploreUnderPrizeEventView.New()
	}
end

return ExploreUnderPrizeEventViewPresentor
