-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/DivineLuciferChallengeViewPresentor.lua

module("logic.extensions.fantian.view.DivineLuciferChallengeViewPresentor", package.seeall)

local DivineLuciferChallengeViewPresentor = class("DivineLuciferChallengeViewPresentor", ViewPresentor)

function DivineLuciferChallengeViewPresentor:ctor()
	DivineLuciferChallengeViewPresentor.super.ctor(self)
end

function DivineLuciferChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLuciferChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/divineluciferchallengeview.prefab"
	}
end

function DivineLuciferChallengeViewPresentor:buildViews()
	return {
		DivineLuciferChallengeView.New()
	}
end

return DivineLuciferChallengeViewPresentor
