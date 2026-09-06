-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeNormalViewPresentor.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeNormalViewPresentor", package.seeall)

local TunTianChallengeNormalViewPresentor = class("TunTianChallengeNormalViewPresentor", ViewPresentor)

function TunTianChallengeNormalViewPresentor:ctor()
	TunTianChallengeNormalViewPresentor.super.ctor(self)
end

function TunTianChallengeNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianChallengeNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianchallenge/tuntianchallengenormalview.prefab"
	}
end

function TunTianChallengeNormalViewPresentor:buildViews()
	return {
		TunTianChallengeNormalView.New()
	}
end

return TunTianChallengeNormalViewPresentor
