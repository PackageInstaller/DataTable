-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderFightEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderFightEventViewPresentor", package.seeall)

local ExploreUnderFightEventViewPresentor = class("ExploreUnderFightEventViewPresentor", ViewPresentor)

function ExploreUnderFightEventViewPresentor:ctor()
	ExploreUnderFightEventViewPresentor.super.ctor(self)
end

function ExploreUnderFightEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderFightEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreunderfighteventview.prefab"
	}
end

function ExploreUnderFightEventViewPresentor:buildViews()
	return {
		ExploreUnderFightEventView.New()
	}
end

return ExploreUnderFightEventViewPresentor
