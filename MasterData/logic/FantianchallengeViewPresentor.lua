-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/FantianchallengeViewPresentor.lua

module("logic.extensions.fantian.view.FantianchallengeViewPresentor", package.seeall)

local FantianchallengeViewPresentor = class("FantianchallengeViewPresentor", ViewPresentor)

function FantianchallengeViewPresentor:ctor()
	FantianchallengeViewPresentor.super.ctor(self)
end

function FantianchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FantianchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/fantianchallengeview.prefab"
	}
end

function FantianchallengeViewPresentor:buildViews()
	return {
		FantianchallengeView.New()
	}
end

return FantianchallengeViewPresentor
