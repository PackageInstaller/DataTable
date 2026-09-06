-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiachallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.Cynthia.CynthiachallengeViewPresentor", package.seeall)

local CynthiachallengeViewPresentor = class("CynthiachallengeViewPresentor", ViewPresentor)

function CynthiachallengeViewPresentor:ctor()
	CynthiachallengeViewPresentor.super.ctor(self)
end

function CynthiachallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CynthiachallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xinxiya/xxychallengeview.prefab"
	}
end

function CynthiachallengeViewPresentor:buildViews()
	return {
		Cynthiachallengeview.New()
	}
end

function CynthiachallengeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CynthiachallengeViewPresentor
