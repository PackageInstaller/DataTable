-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiChallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiChallengeViewPresentor", package.seeall)

local MississiChallengeViewPresentor = class("MississiChallengeViewPresentor", ViewPresentor)

function MississiChallengeViewPresentor:ctor()
	MississiChallengeViewPresentor.super.ctor(self)
end

function MississiChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MississiChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mississi/mississichallengeview.prefab"
	}
end

function MississiChallengeViewPresentor:buildViews()
	return {
		MississiChallengeView.New()
	}
end

return MississiChallengeViewPresentor
