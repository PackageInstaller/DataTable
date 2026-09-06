-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonextremechallengeViewPresentor.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonextremechallengeViewPresentor", package.seeall)

local DualdragonextremechallengeViewPresentor = class("DualdragonextremechallengeViewPresentor", ViewPresentor)

function DualdragonextremechallengeViewPresentor:ctor()
	DualdragonextremechallengeViewPresentor.super.ctor(self)
end

function DualdragonextremechallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualdragonextremechallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/dualdragonchallenge/dualdragonextremechallengeview.prefab"
	}
end

function DualdragonextremechallengeViewPresentor:buildViews()
	return {
		DualdragonextremechallengeView.New()
	}
end

return DualdragonextremechallengeViewPresentor
