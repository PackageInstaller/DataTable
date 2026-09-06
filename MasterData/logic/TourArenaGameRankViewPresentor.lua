-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameRankViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaGameRankViewPresentor", package.seeall)

local TourArenaGameRankViewPresentor = class("TourArenaGameRankViewPresentor", ViewPresentor)

function TourArenaGameRankViewPresentor:ctor()
	TourArenaGameRankViewPresentor.super.ctor(self)
end

function TourArenaGameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaGameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/tourarenagamerankview.prefab"
	}
end

function TourArenaGameRankViewPresentor:buildViews()
	return {
		TourArenaGameRankView.New()
	}
end

return TourArenaGameRankViewPresentor
