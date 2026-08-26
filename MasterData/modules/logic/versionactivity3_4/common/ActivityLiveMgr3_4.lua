-- chunkname: @modules/logic/versionactivity3_4/common/ActivityLiveMgr3_4.lua

module("modules.logic.versionactivity3_4.common.ActivityLiveMgr3_4", package.seeall)

local ActivityLiveMgr3_4 = class("ActivityLiveMgr3_4")

function ActivityLiveMgr3_4:init()
	return
end

function ActivityLiveMgr3_4:getActId2ViewList()
	return {
		[VersionActivity3_4Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_4EnterView
		},
		[VersionActivity3_4Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_4StoreView
		},
		[VersionActivity3_4Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_4TaskView,
			ViewName.VersionActivity3_4DungeonMapView
		},
		[VersionActivity3_4Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_5DungeonMapView,
			ViewName.VersionActivity2_5DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity3_4Enum.ActivityId.PartyGame] = {
			ViewName.PartyGameLobbyMainView,
			ViewName.PartyClothLotteryView,
			ViewName.PartyClothView
		},
		[VersionActivity3_4Enum.ActivityId.PartyGameStore] = {
			ViewName.PartyGameLobbyStoreView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_4.instance = ActivityLiveMgr3_4.New()

return ActivityLiveMgr3_4
