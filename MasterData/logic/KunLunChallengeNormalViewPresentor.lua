-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeNormalViewPresentor.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeNormalViewPresentor", package.seeall)

local KunLunChallengeNormalViewPresentor = class("KunLunChallengeNormalViewPresentor", ViewPresentor)

function KunLunChallengeNormalViewPresentor:ctor()
	KunLunChallengeNormalViewPresentor.super.ctor(self)
end

function KunLunChallengeNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunLunChallengeNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/kunlunchallenge/kunlunchallengenormalview.prefab"
	}
end

function KunLunChallengeNormalViewPresentor:buildViews()
	return {
		KunLunChallengeNormalView.New()
	}
end

return KunLunChallengeNormalViewPresentor
