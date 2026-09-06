-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonScheduleRankTabChildViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonScheduleRankTabChildViewPresentor", package.seeall)

local GodStatuesWarSeasonScheduleRankTabChildViewPresentor = class("GodStatuesWarSeasonScheduleRankTabChildViewPresentor", ViewPresentor)

function GodStatuesWarSeasonScheduleRankTabChildViewPresentor:ctor()
	GodStatuesWarSeasonScheduleRankTabChildViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonScheduleRankTabChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarSeasonScheduleRankTabChildViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasonscheduleranktabchildview.prefab"
	}
end

function GodStatuesWarSeasonScheduleRankTabChildViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonScheduleRankTabChildView.New()
	}
end

function GodStatuesWarSeasonScheduleRankTabChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarSeasonScheduleRankTabChildViewPresentor
