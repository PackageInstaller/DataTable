-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeMainViewPresentor.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeMainViewPresentor", package.seeall)

local KunLunChallengeMainViewPresentor = class("KunLunChallengeMainViewPresentor", ViewPresentor)

function KunLunChallengeMainViewPresentor:ctor()
	KunLunChallengeMainViewPresentor.super.ctor(self)
end

function KunLunChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KunLunChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kunlunchallenge/kunlunchallengemainview.prefab"
	}
end

function KunLunChallengeMainViewPresentor:buildViews()
	return {
		KunLunChallengeMainView.New()
	}
end

return KunLunChallengeMainViewPresentor
