-- chunkname: @modules/logic/versionactivity3_5/common/ActivityLiveMgr3_5.lua

module("modules.logic.versionactivity3_5.common.ActivityLiveMgr3_5", package.seeall)

local ActivityLiveMgr3_5 = class("ActivityLiveMgr3_5")

function ActivityLiveMgr3_5:init()
	return
end

function ActivityLiveMgr3_5:getActId2ViewList()
	return {
		[VersionActivity3_5Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_5EnterView
		},
		[VersionActivity3_5Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_5StoreView
		},
		[VersionActivity3_5Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_5TaskView,
			ViewName.VersionActivity3_5DungeonMapView
		},
		[VersionActivity3_5Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_5DungeonMapView,
			ViewName.VersionActivity2_5DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_5.instance = ActivityLiveMgr3_5.New()

return ActivityLiveMgr3_5
