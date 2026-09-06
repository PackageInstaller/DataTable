-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameMainViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaGameMainViewPresentor", package.seeall)

local TourArenaGameMainViewPresentor = class("TourArenaGameMainViewPresentor", ViewPresentor)

function TourArenaGameMainViewPresentor:ctor()
	TourArenaGameMainViewPresentor.super.ctor(self)
end

function TourArenaGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/tourarenagamemainview.prefab"
	}
end

function TourArenaGameMainViewPresentor:buildViews()
	return {
		TourArenaGameMainView.New()
	}
end

return TourArenaGameMainViewPresentor
