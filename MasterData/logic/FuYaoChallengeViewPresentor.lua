-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoChallengeViewPresentor.lua

module("logic.extensions.fuyao.view.FuYaoChallengeViewPresentor", package.seeall)

local FuYaoChallengeViewPresentor = class("FuYaoChallengeViewPresentor", ViewPresentor)

function FuYaoChallengeViewPresentor:ctor()
	FuYaoChallengeViewPresentor.super.ctor(self)
end

function FuYaoChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuYaoChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fuyao/fuyaochallengeview.prefab"
	}
end

function FuYaoChallengeViewPresentor:buildViews()
	return {
		FuYaoChallengeView.New()
	}
end

return FuYaoChallengeViewPresentor
