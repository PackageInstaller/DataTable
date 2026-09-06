-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeSureViewPresentor.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeSureViewPresentor", package.seeall)

local TunTianChallengeExtremeSureViewPresentor = class("TunTianChallengeExtremeSureViewPresentor", ViewPresentor)

function TunTianChallengeExtremeSureViewPresentor:ctor()
	TunTianChallengeExtremeSureViewPresentor.super.ctor(self)
end

function TunTianChallengeExtremeSureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianChallengeExtremeSureViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianchallenge/tuntianchallengeextremesureview.prefab"
	}
end

function TunTianChallengeExtremeSureViewPresentor:buildViews()
	return {
		TunTianChallengeExtremeSureView.New()
	}
end

return TunTianChallengeExtremeSureViewPresentor
