-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameTotalRankViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaGameTotalRankViewPresentor", package.seeall)

local TourArenaGameTotalRankViewPresentor = class("TourArenaGameTotalRankViewPresentor", ViewPresentor)

function TourArenaGameTotalRankViewPresentor:ctor()
	TourArenaGameTotalRankViewPresentor.super.ctor(self)
end

function TourArenaGameTotalRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaGameTotalRankViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/tourarenagametotalrankview.prefab"
	}
end

function TourArenaGameTotalRankViewPresentor:buildViews()
	return {
		TourArenaGameTotalRankView.New()
	}
end

return TourArenaGameTotalRankViewPresentor
