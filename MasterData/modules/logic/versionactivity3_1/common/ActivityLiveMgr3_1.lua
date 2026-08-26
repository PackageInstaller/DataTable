-- chunkname: @modules/logic/versionactivity3_1/common/ActivityLiveMgr3_1.lua

module("modules.logic.versionactivity3_1.common.ActivityLiveMgr3_1", package.seeall)

local ActivityLiveMgr3_1 = class("ActivityLiveMgr3_1")

function ActivityLiveMgr3_1:init()
	return
end

function ActivityLiveMgr3_1:getActId2ViewList()
	return {
		[VersionActivity3_1Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_1EnterView
		},
		[VersionActivity3_1Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_1StoreView
		},
		[VersionActivity3_1Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_1TaskView
		},
		[VersionActivity3_1Enum.ActivityId.Survival] = {
			ViewName.SurvivalMainView,
			ViewName.SurvivalMapView
		},
		[VersionActivity3_1Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_4DungeonMapView,
			ViewName.VersionActivity2_4DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_1.instance = ActivityLiveMgr3_1.New()

return ActivityLiveMgr3_1
