-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwindragonchallengeViewPresentor.lua

module("logic.extensions.twindragonchallenge.view.TwindragonchallengeViewPresentor", package.seeall)

local TwindragonchallengeViewPresentor = class("TwindragonchallengeViewPresentor", ViewPresentor)

function TwindragonchallengeViewPresentor:ctor()
	TwindragonchallengeViewPresentor.super.ctor(self)
end

function TwindragonchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TwindragonchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/twindragonchallenge/twindragonchallengeview.prefab"
	}
end

function TwindragonchallengeViewPresentor:buildViews()
	return {
		TwinDragonChallengeView.New()
	}
end

return TwindragonchallengeViewPresentor
