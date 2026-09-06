-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownScheduleViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownScheduleViewPresentor", package.seeall)

local ShowDownScheduleViewPresentor = class("ShowDownScheduleViewPresentor", ViewPresentor)

function ShowDownScheduleViewPresentor:ctor()
	ShowDownScheduleViewPresentor.super.ctor(self)
end

function ShowDownScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownscheduleview.prefab"
	}
end

function ShowDownScheduleViewPresentor:buildViews()
	return {
		ShowDownScheduleView.New()
	}
end

function ShowDownScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownScheduleViewPresentor
