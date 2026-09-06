-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightTotalRankFatherViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaFightTotalRankFatherViewPresentor", package.seeall)

local TourArenaFightTotalRankFatherViewPresentor = class("TourArenaFightTotalRankFatherViewPresentor", ViewPresentor)

function TourArenaFightTotalRankFatherViewPresentor:ctor()
	TourArenaFightTotalRankFatherViewPresentor.super.ctor(self)
end

function TourArenaFightTotalRankFatherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaFightTotalRankFatherViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/fight/tourarenafighttotalrankfatherview.prefab"
	}
end

function TourArenaFightTotalRankFatherViewPresentor:buildViews()
	return {
		TourArenaFightTotalRankFatherView.New()
	}
end

return TourArenaFightTotalRankFatherViewPresentor
