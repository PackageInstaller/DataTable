-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/HolyDarkMMChallengeViewPresentor.lua

module("logic.extensions.holydarkmm.view.HolyDarkMMChallengeViewPresentor", package.seeall)

local HolyDarkMMChallengeViewPresentor = class("HolyDarkMMChallengeViewPresentor", ViewPresentor)

function HolyDarkMMChallengeViewPresentor:ctor()
	HolyDarkMMChallengeViewPresentor.super.ctor(self)
end

function HolyDarkMMChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDarkMMChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holydarkmm/holydarkmmchallengeview.prefab"
	}
end

function HolyDarkMMChallengeViewPresentor:buildViews()
	return {
		HolyDarkMMChallengeView.New()
	}
end

return HolyDarkMMChallengeViewPresentor
