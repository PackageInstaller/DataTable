-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/ReturnChallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.ReturnChallengeViewPresentor", package.seeall)

local ReturnChallengeViewPresentor = class("ReturnChallengeViewPresentor", ViewPresentor)

function ReturnChallengeViewPresentor:ctor()
	ReturnChallengeViewPresentor.super.ctor(self)
end

function ReturnChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReturnChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/return/returnchallengeview.prefab"
	}
end

function ReturnChallengeViewPresentor:buildViews()
	return {
		ReturnChallengeView.New()
	}
end

return ReturnChallengeViewPresentor
