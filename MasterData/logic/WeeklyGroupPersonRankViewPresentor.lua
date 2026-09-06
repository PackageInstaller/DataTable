-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupPersonRankViewPresentor.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupPersonRankViewPresentor", package.seeall)

local WeeklyGroupPersonRankViewPresentor = class("WeeklyGroupPersonRankViewPresentor", ViewPresentor)

function WeeklyGroupPersonRankViewPresentor:ctor()
	WeeklyGroupPersonRankViewPresentor.super.ctor(self)
end

function WeeklyGroupPersonRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WeeklyGroupPersonRankViewPresentor:dependWhatResources()
	return {
		"ui/views/weeklygroup/weeklygrouppersonrankview.prefab"
	}
end

function WeeklyGroupPersonRankViewPresentor:buildViews()
	return {
		WeeklyGroupPersonRankView.New()
	}
end

return WeeklyGroupPersonRankViewPresentor
