-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/FemalepsychicchallengeViewPresentor.lua

module("logic.extensions.femalepsychic.view.FemalepsychicchallengeViewPresentor", package.seeall)

local FemalepsychicchallengeViewPresentor = class("FemalepsychicchallengeViewPresentor", ViewPresentor)

function FemalepsychicchallengeViewPresentor:ctor()
	FemalepsychicchallengeViewPresentor.super.ctor(self)
end

function FemalepsychicchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemalepsychicchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/femalepsychicchallengeview.prefab"
	}
end

function FemalepsychicchallengeViewPresentor:buildViews()
	return {
		FemalePsychicChallengeView.New()
	}
end

return FemalepsychicchallengeViewPresentor
