-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightWeeklyRankChildViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaFightWeeklyRankChildViewPresentor", package.seeall)

local TourArenaFightWeeklyRankChildViewPresentor = class("TourArenaFightWeeklyRankChildViewPresentor", ViewPresentor)

function TourArenaFightWeeklyRankChildViewPresentor:ctor()
	TourArenaFightWeeklyRankChildViewPresentor.super.ctor(self)
end

function TourArenaFightWeeklyRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaFightWeeklyRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/fight/tourarenafightweeklyrankchildview.prefab"
	}
end

function TourArenaFightWeeklyRankChildViewPresentor:buildViews()
	return {
		TourArenaFightWeeklyRankChildView.New()
	}
end

function TourArenaFightWeeklyRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TourArenaFightWeeklyRankChildViewPresentor
