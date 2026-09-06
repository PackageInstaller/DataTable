-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameStageSelectViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaGameStageSelectViewPresentor", package.seeall)

local TourArenaGameStageSelectViewPresentor = class("TourArenaGameStageSelectViewPresentor", ViewPresentor)

function TourArenaGameStageSelectViewPresentor:ctor()
	TourArenaGameStageSelectViewPresentor.super.ctor(self)
end

function TourArenaGameStageSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaGameStageSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/tourarenagamestageselectview.prefab"
	}
end

function TourArenaGameStageSelectViewPresentor:buildViews()
	return {
		TourArenaGameStageSelectView.New()
	}
end

return TourArenaGameStageSelectViewPresentor
