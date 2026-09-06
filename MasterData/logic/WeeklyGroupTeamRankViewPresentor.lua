-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupTeamRankViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupTeamRankViewPresentor", package.seeall)

local WeeklyGroupTeamRankViewPresentor = class("WeeklyGroupTeamRankViewPresentor", ViewPresentor)

function WeeklyGroupTeamRankViewPresentor:ctor()
	WeeklyGroupTeamRankViewPresentor.super.ctor(self)
end

function WeeklyGroupTeamRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupTeamRankViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygroupteamrankview.prefab"
	}
end

function WeeklyGroupTeamRankViewPresentor:buildViews()
	return {
		WeeklyGroupTeamRankView.New()
	}
end

return WeeklyGroupTeamRankViewPresentor
