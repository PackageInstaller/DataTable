-- chunkname: @modules/logic/versionactivity3_7/common/ActivityLiveMgr3_7.lua

module("modules.logic.versionactivity3_7.common.ActivityLiveMgr3_7", package.seeall)

local ActivityLiveMgr3_7 = class("ActivityLiveMgr3_7")

function ActivityLiveMgr3_7:init()
	return
end

function ActivityLiveMgr3_7:getActId2ViewList()
	return {
		[VersionActivity3_7Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_7EnterView
		},
		[VersionActivity3_7Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity3_7Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_7TaskView,
			ViewName.VersionActivity3_7DungeonMapView
		},
		[VersionActivity3_7Enum.ActivityId.ArcadeV3a7] = {
			ViewName.ArcadeHallView,
			ViewName.ArcadeGameView
		},
		[VersionActivity3_7Enum.ActivityId.XRuiAnYi] = {
			ViewName.XRuiAnYiLevelView,
			ViewName.XRuiAnYiTaskView,
			ViewName.TravelGoView
		},
		[VersionActivity3_7Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_5DungeonMapView,
			ViewName.VersionActivity2_5DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity3_7Enum.ActivityId.Abyss] = {
			ViewName.AbyssEnterView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_7.instance = ActivityLiveMgr3_7.New()

return ActivityLiveMgr3_7
