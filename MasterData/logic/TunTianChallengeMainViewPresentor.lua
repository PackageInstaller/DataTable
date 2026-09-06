-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeMainViewPresentor.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeMainViewPresentor", package.seeall)

local TunTianChallengeMainViewPresentor = class("TunTianChallengeMainViewPresentor", ViewPresentor)

function TunTianChallengeMainViewPresentor:ctor()
	TunTianChallengeMainViewPresentor.super.ctor(self)
end

function TunTianChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianchallenge/tuntianchallengemainview.prefab"
	}
end

function TunTianChallengeMainViewPresentor:buildViews()
	return {
		TunTianChallengeMainView.New()
	}
end

return TunTianChallengeMainViewPresentor
