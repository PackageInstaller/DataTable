-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeViewPresentor.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeViewPresentor", package.seeall)

local TunTianChallengeExtremeViewPresentor = class("TunTianChallengeExtremeViewPresentor", ViewPresentor)

function TunTianChallengeExtremeViewPresentor:ctor()
	TunTianChallengeExtremeViewPresentor.super.ctor(self)
end

function TunTianChallengeExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianChallengeExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianchallenge/tuntianchallengeextremeview.prefab"
	}
end

function TunTianChallengeExtremeViewPresentor:buildViews()
	return {
		TunTianChallengeExtremeView.New()
	}
end

return TunTianChallengeExtremeViewPresentor
