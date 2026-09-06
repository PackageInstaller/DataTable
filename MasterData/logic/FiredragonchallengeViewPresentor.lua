-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonchallengeViewPresentor.lua

module("logic.extensions.infinitefuture.view.FiredragonchallengeViewPresentor", package.seeall)

local FiredragonchallengeViewPresentor = class("FiredragonchallengeViewPresentor", ViewPresentor)

function FiredragonchallengeViewPresentor:ctor()
	FiredragonchallengeViewPresentor.super.ctor(self)
end

function FiredragonchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiredragonchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/firedragon/firedragonchallengeview.prefab"
	}
end

function FiredragonchallengeViewPresentor:buildViews()
	return {
		FiredragonchallengeView.New()
	}
end

return FiredragonchallengeViewPresentor
