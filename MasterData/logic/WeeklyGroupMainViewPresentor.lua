-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupMainViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupMainViewPresentor", package.seeall)

local WeeklyGroupMainViewPresentor = class("WeeklyGroupMainViewPresentor", ViewPresentor)

function WeeklyGroupMainViewPresentor:ctor()
	WeeklyGroupMainViewPresentor.super.ctor(self)
end

function WeeklyGroupMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupMainViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygroupmainview.prefab"
	}
end

function WeeklyGroupMainViewPresentor:buildViews()
	return {
		WeeklyGroupMainView.New()
	}
end

return WeeklyGroupMainViewPresentor
