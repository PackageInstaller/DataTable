-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanchallengeViewPresentor.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanchallengeViewPresentor", package.seeall)

local OrizhmoyanchallengeViewPresentor = class("OrizhmoyanchallengeViewPresentor", ViewPresentor)

function OrizhmoyanchallengeViewPresentor:ctor()
	OrizhmoyanchallengeViewPresentor.super.ctor(self)
end

function OrizhmoyanchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrizhmoyanchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/copy/orizhmoyanchallengeview.prefab"
	}
end

function OrizhmoyanchallengeViewPresentor:buildViews()
	return {
		OrizhmoyanchallengeView.New()
	}
end

return OrizhmoyanchallengeViewPresentor
