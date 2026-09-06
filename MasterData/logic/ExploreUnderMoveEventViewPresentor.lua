-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderMoveEventViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderMoveEventViewPresentor", package.seeall)

local ExploreUnderMoveEventViewPresentor = class("ExploreUnderMoveEventViewPresentor", ViewPresentor)

function ExploreUnderMoveEventViewPresentor:ctor()
	ExploreUnderMoveEventViewPresentor.super.ctor(self)
end

function ExploreUnderMoveEventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderMoveEventViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundermoveeventview.prefab"
	}
end

function ExploreUnderMoveEventViewPresentor:buildViews()
	return {
		ExploreUnderMoveEventView.New()
	}
end

return ExploreUnderMoveEventViewPresentor
