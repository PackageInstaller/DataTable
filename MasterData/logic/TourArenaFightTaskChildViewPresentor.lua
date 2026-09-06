-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/tourarena/TourArenaFightTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.tourarena.TourArenaFightTaskChildViewPresentor", package.seeall)

local TourArenaFightTaskChildViewPresentor = class("TourArenaFightTaskChildViewPresentor", ViewPresentor)

function TourArenaFightTaskChildViewPresentor:ctor()
	TourArenaFightTaskChildViewPresentor.super.ctor(self)
end

function TourArenaFightTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TourArenaFightTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/tourarena/tourarenafighttaskchildview.prefab"
	}
end

function TourArenaFightTaskChildViewPresentor:buildViews()
	return {
		TourArenaFightTaskChildView.New()
	}
end

function TourArenaFightTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TourArenaFightTaskChildViewPresentor
