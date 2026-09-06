-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderDiceViewPresentor.lua

module("logic.extensions.exploreunder.view.ExploreUnderDiceViewPresentor", package.seeall)

local ExploreUnderDiceViewPresentor = class("ExploreUnderDiceViewPresentor", ViewPresentor)

function ExploreUnderDiceViewPresentor:ctor()
	ExploreUnderDiceViewPresentor.super.ctor(self)
end

function ExploreUnderDiceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExploreUnderDiceViewPresentor:dependWhatResources()
	return {
		"ui/views/exploreunder/exploreunderdiceview.prefab"
	}
end

function ExploreUnderDiceViewPresentor:buildViews()
	return {
		ExploreUnderDiceView.New()
	}
end

return ExploreUnderDiceViewPresentor
