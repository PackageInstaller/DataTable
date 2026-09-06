-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/tourarena/TourArenaFightTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.tourarena.TourArenaFightTaskFrameViewPresentor", package.seeall)

local TourArenaFightTaskFrameViewPresentor = class("TourArenaFightTaskFrameViewPresentor", ViewPresentor)

function TourArenaFightTaskFrameViewPresentor:ctor()
	TourArenaFightTaskFrameViewPresentor.super.ctor(self)
end

function TourArenaFightTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TourArenaFightTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/tourarena/tourarenafighttaskframeview.prefab"
	}
end

function TourArenaFightTaskFrameViewPresentor:buildViews()
	return {
		TourArenaFightTaskFrameView.New()
	}
end

return TourArenaFightTaskFrameViewPresentor
