-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightPeriodRankChildViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaFightPeriodRankChildViewPresentor", package.seeall)

local TourArenaFightPeriodRankChildViewPresentor = class("TourArenaFightPeriodRankChildViewPresentor", ViewPresentor)

function TourArenaFightPeriodRankChildViewPresentor:ctor()
	TourArenaFightPeriodRankChildViewPresentor.super.ctor(self)
end

function TourArenaFightPeriodRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaFightPeriodRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/fight/tourarenafightperiodrankchildview.prefab"
	}
end

function TourArenaFightPeriodRankChildViewPresentor:buildViews()
	return {
		TourArenaFightPeriodRankChildView.New()
	}
end

function TourArenaFightPeriodRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TourArenaFightPeriodRankChildViewPresentor
