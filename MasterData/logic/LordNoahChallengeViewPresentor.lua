-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lordnoah/LordNoahChallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lordnoah.LordNoahChallengeViewPresentor", package.seeall)

local LordNoahChallengeViewPresentor = class("LordNoahChallengeViewPresentor", ViewPresentor)

function LordNoahChallengeViewPresentor:ctor()
	LordNoahChallengeViewPresentor.super.ctor(self)
end

function LordNoahChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LordNoahChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lordnoah/lordnoahchallengeview.prefab"
	}
end

function LordNoahChallengeViewPresentor:buildViews()
	return {
		LordNoahChallengeView.New()
	}
end

return LordNoahChallengeViewPresentor
