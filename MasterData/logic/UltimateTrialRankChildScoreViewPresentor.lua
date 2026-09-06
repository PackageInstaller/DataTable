-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialRankChildScoreViewPresentor.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialRankChildScoreViewPresentor", package.seeall)

local UltimateTrialRankChildScoreViewPresentor = class("UltimateTrialRankChildScoreViewPresentor", ViewPresentor)

function UltimateTrialRankChildScoreViewPresentor:ctor()
	UltimateTrialRankChildScoreViewPresentor.super.ctor(self)
end

function UltimateTrialRankChildScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialRankChildScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatetrial/ultimatetrialrankchildscoreview.prefab"
	}
end

function UltimateTrialRankChildScoreViewPresentor:buildViews()
	return {
		UltimateTrialRankChildScoreView.New()
	}
end

function UltimateTrialRankChildScoreViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UltimateTrialRankChildScoreViewPresentor
