-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaSelectViewPresentor.lua

module("logic.extensions.tourarena.view.TourArenaSelectViewPresentor", package.seeall)

local TourArenaSelectViewPresentor = class("TourArenaSelectViewPresentor", ViewPresentor)

function TourArenaSelectViewPresentor:ctor()
	TourArenaSelectViewPresentor.super.ctor(self)
end

function TourArenaSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TourArenaSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/tourarenaselectview.prefab"
	}
end

function TourArenaSelectViewPresentor:buildViews()
	return {
		TourArenaSelectView.New()
	}
end

return TourArenaSelectViewPresentor
