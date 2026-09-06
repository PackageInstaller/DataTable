-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightMainViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaFightMainViewPresentor", package.seeall)

local TourArenaFightMainViewPresentor = class("TourArenaFightMainViewPresentor", ViewPresentor)

function TourArenaFightMainViewPresentor:ctor()
	TourArenaFightMainViewPresentor.super.ctor(self)
end

function TourArenaFightMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaFightMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/fight/tourarenafightmainview.prefab"
	}
end

function TourArenaFightMainViewPresentor:buildViews()
	return {
		TourArenaFightMainView.New()
	}
end

return TourArenaFightMainViewPresentor
