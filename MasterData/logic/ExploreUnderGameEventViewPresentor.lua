-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderGameEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderGameEventViewPresentor", package.seeall)

local ExploreUnderGameEventViewPresentor = class("ExploreUnderGameEventViewPresentor", ViewPresentor)

function ExploreUnderGameEventViewPresentor:ctor()
	ExploreUnderGameEventViewPresentor.super.ctor(self)
end

function ExploreUnderGameEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderGameEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundergameeventview.prefab"
	}
end

function ExploreUnderGameEventViewPresentor:buildViews()
	return {
		ExploreUnderGameEventView.New()
	}
end

return ExploreUnderGameEventViewPresentor
