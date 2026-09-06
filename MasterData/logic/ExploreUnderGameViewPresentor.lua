-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderGameViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderGameViewPresentor", package.seeall)

local ExploreUnderGameViewPresentor = class("ExploreUnderGameViewPresentor", ViewPresentor)

function ExploreUnderGameViewPresentor:ctor()
	ExploreUnderGameViewPresentor.super.ctor(self)
end

function ExploreUnderGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderGameViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundergameview.prefab"
	}
end

function ExploreUnderGameViewPresentor:buildViews()
	return {
		ExploreUnderGameView.New()
	}
end

return ExploreUnderGameViewPresentor
