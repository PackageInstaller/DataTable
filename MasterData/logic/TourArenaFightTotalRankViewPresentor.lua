-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightTotalRankViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaFightTotalRankViewPresentor", package.seeall)

local TourArenaFightTotalRankViewPresentor = class("TourArenaFightTotalRankViewPresentor", ViewPresentor)

function TourArenaFightTotalRankViewPresentor:ctor()
	TourArenaFightTotalRankViewPresentor.super.ctor(self)
end

function TourArenaFightTotalRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaFightTotalRankViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/fight/tourarenafighttotalrankview.prefab"
	}
end

function TourArenaFightTotalRankViewPresentor:buildViews()
	return {
		TourArenaFightTotalRankView.New()
	}
end

return TourArenaFightTotalRankViewPresentor
