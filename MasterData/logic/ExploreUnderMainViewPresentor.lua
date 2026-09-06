-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderMainViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderMainViewPresentor", package.seeall)

local ExploreUnderMainViewPresentor = class("ExploreUnderMainViewPresentor", ViewPresentor)

function ExploreUnderMainViewPresentor:ctor()
	ExploreUnderMainViewPresentor.super.ctor(self)
end

function ExploreUnderMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderMainViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreundermainview.prefab"
	}
end

function ExploreUnderMainViewPresentor:buildViews()
	return {
		ExploreUnderMainView.New()
	}
end

return ExploreUnderMainViewPresentor
