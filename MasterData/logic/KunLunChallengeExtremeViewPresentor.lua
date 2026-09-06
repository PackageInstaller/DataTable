-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeExtremeViewPresentor.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeExtremeViewPresentor", package.seeall)

local KunLunChallengeExtremeViewPresentor = class("KunLunChallengeExtremeViewPresentor", ViewPresentor)

function KunLunChallengeExtremeViewPresentor:ctor()
	KunLunChallengeExtremeViewPresentor.super.ctor(self)
end

function KunLunChallengeExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunLunChallengeExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/kunlunchallenge/kunlunchallengeextremeview.prefab"
	}
end

function KunLunChallengeExtremeViewPresentor:buildViews()
	return {
		KunLunChallengeExtremeView.New()
	}
end

return KunLunChallengeExtremeViewPresentor
