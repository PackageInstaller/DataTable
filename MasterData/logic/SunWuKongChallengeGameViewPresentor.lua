-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeGameViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeGameViewPresentor", package.seeall)

local SunWuKongChallengeGameViewPresentor = class("SunWuKongChallengeGameViewPresentor", ViewPresentor)

function SunWuKongChallengeGameViewPresentor:ctor()
	SunWuKongChallengeGameViewPresentor.super.ctor(self)
end

function SunWuKongChallengeGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SunWuKongChallengeGameViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengegameview.prefab"
	}
end

function SunWuKongChallengeGameViewPresentor:buildViews()
	return {
		SunWuKongChallengeGameView.New()
	}
end

return SunWuKongChallengeGameViewPresentor
