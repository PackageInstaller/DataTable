-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/view/TunTianChallengeExtremeStageViewPresentor.lua

module("logic.extensions.tuntianchallenge.view.TunTianChallengeExtremeStageViewPresentor", package.seeall)

local TunTianChallengeExtremeStageViewPresentor = class("TunTianChallengeExtremeStageViewPresentor", ViewPresentor)

function TunTianChallengeExtremeStageViewPresentor:ctor()
	TunTianChallengeExtremeStageViewPresentor.super.ctor(self)
end

function TunTianChallengeExtremeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianChallengeExtremeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianchallenge/tuntianchallengeextremestageview.prefab"
	}
end

function TunTianChallengeExtremeStageViewPresentor:buildViews()
	return {
		TunTianChallengeExtremeStageView.New()
	}
end

return TunTianChallengeExtremeStageViewPresentor
