-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossScheduleViewPresentor.lua

module("logic.extensions.worldboss.view.WorldBossScheduleViewPresentor", package.seeall)

local WorldBossScheduleViewPresentor = class("WorldBossScheduleViewPresentor", ViewPresentor)

function WorldBossScheduleViewPresentor:ctor()
	WorldBossScheduleViewPresentor.super.ctor(self)
end

function WorldBossScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldBossScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/worldboss/worldbossscheduleview.prefab"
	}
end

function WorldBossScheduleViewPresentor:buildViews()
	return {
		WorldBossScheduleView.New()
	}
end

return WorldBossScheduleViewPresentor
