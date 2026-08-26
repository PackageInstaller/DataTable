-- chunkname: @modules/logic/versionactivity2_7/common/ActivityLiveMgr2_7.lua

module("modules.logic.versionactivity2_7.common.ActivityLiveMgr2_7", package.seeall)

local ActivityLiveMgr2_7 = class("ActivityLiveMgr2_7")

function ActivityLiveMgr2_7:init()
	return
end

function ActivityLiveMgr2_7:getActId2ViewList()
	return {
		[VersionActivity2_7Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_7EnterView
		},
		[VersionActivity2_7Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_7StoreView
		},
		[VersionActivity2_7Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_7TaskView
		},
		[VersionActivity2_7Enum.ActivityId.CooperGarland] = {
			ViewName.CooperGarlandGameView,
			ViewName.CooperGarlandLevelView,
			ViewName.CooperGarlandTaskView
		},
		[VersionActivity2_7Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_0DungeonMapView,
			ViewName.VersionActivity2_0DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_7Enum.ActivityId.DungeonGraffiti] = {
			ViewName.VersionActivity2_0DungeonGraffitiDrawView,
			ViewName.VersionActivity2_0DungeonGraffitiView
		},
		[VersionActivity2_7Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr2_7.instance = ActivityLiveMgr2_7.New()

return ActivityLiveMgr2_7
