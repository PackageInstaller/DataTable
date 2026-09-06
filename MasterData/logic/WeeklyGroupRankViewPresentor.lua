-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupRankViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupRankViewPresentor", package.seeall)

local WeeklyGroupRankViewPresentor = class("WeeklyGroupRankViewPresentor", ViewPresentor)

function WeeklyGroupRankViewPresentor:ctor()
	WeeklyGroupRankViewPresentor.super.ctor(self)
end

function WeeklyGroupRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupRankViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygrouprankview.prefab"
	}
end

function WeeklyGroupRankViewPresentor:buildViews()
	return {
		WeeklyGroupRankView.New()
	}
end

return WeeklyGroupRankViewPresentor
