-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTaskViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTaskViewPresentor", package.seeall)

local WeeklyGroupTaskViewPresentor = class("WeeklyGroupTaskViewPresentor", ViewPresentor)

function WeeklyGroupTaskViewPresentor:ctor()
	WeeklyGroupTaskViewPresentor.super.ctor(self)
end

function WeeklyGroupTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygrouptaskview.prefab"
	}
end

function WeeklyGroupTaskViewPresentor:buildViews()
	return {
		WeeklyGroupTaskView.New()
	}
end

return WeeklyGroupTaskViewPresentor
