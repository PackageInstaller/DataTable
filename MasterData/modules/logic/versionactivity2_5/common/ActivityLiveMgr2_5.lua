-- chunkname: @modules/logic/versionactivity2_5/common/ActivityLiveMgr2_5.lua

module("modules.logic.versionactivity2_5.common.ActivityLiveMgr2_5", package.seeall)

local ActivityLiveMgr2_5 = class("ActivityLiveMgr2_5")

function ActivityLiveMgr2_5:init()
	return
end

function ActivityLiveMgr2_5:getActId2ViewList()
	return {
		[VersionActivity2_5Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_5EnterView
		},
		[VersionActivity2_5Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_5StoreView
		},
		[VersionActivity2_5Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_5TaskView
		},
		[VersionActivity2_5Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_6DungeonMapView,
			ViewName.VersionActivity1_6DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_5Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity2_5Enum.ActivityId.FeiLinShiDuo] = {
			ViewName.FeiLinShiDuoEpisodeLevelView,
			ViewName.FeiLinShiDuoGameView,
			ViewName.FeiLinShiDuoTaskView
		},
		[VersionActivity2_5Enum.ActivityId.LiangYue] = {
			ViewName.LiangYueLevelView,
			ViewName.LiangYueGameView,
			ViewName.LiangYueTaskView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		},
		[VersionActivity2_5Enum.ActivityId.Act186] = {
			ViewName.Activity186View,
			ViewName.Activity186TaskView
		},
		[VersionActivity2_5Enum.ActivityId.Act186Sign] = {
			ViewName.Activity186SignView
		}
	}
end

ActivityLiveMgr2_5.instance = ActivityLiveMgr2_5.New()

return ActivityLiveMgr2_5
