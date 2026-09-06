-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTaskCellViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTaskCellViewPresentor", package.seeall)

local WeeklyGroupTaskCellViewPresentor = class("WeeklyGroupTaskCellViewPresentor", ViewPresentor)

function WeeklyGroupTaskCellViewPresentor:ctor()
	WeeklyGroupTaskCellViewPresentor.super.ctor(self)
end

function WeeklyGroupTaskCellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupTaskCellViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygrouptaskcellview.prefab"
	}
end

function WeeklyGroupTaskCellViewPresentor:buildViews()
	return {
		WeeklyGroupTaskCellView.New()
	}
end

return WeeklyGroupTaskCellViewPresentor
