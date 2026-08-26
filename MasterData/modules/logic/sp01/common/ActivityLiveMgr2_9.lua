-- chunkname: @modules/logic/sp01/common/ActivityLiveMgr2_9.lua

module("modules.logic.sp01.common.ActivityLiveMgr2_9", package.seeall)

local ActivityLiveMgr2_9 = class("ActivityLiveMgr2_9")

function ActivityLiveMgr2_9:init()
	return
end

function ActivityLiveMgr2_9:getActId2ViewList()
	return {
		[VersionActivity2_9Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_9EnterView
		},
		[VersionActivity2_9Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_9StoreView
		},
		[VersionActivity2_9Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_9DungeonMapView,
			ViewName.VersionActivity2_9HeroGroupFightView
		},
		[VersionActivity2_9Enum.ActivityId.Outside] = {
			ViewName.AssassinLoginView,
			ViewName.AssassinMapView,
			ViewName.AssassinQuestMapView,
			ViewName.AssassinHeroView,
			ViewName.AssassinStealthGameView
		},
		[VersionActivity2_9Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity2_9Enum.ActivityId.Dungeon2] = {
			ViewName.OdysseyDungeonView,
			ViewName.OdysseyTaskView,
			ViewName.OdysseyHeroGroupView
		},
		[ActivityEnum.Activity.V2a9_ActCollection] = {
			ViewName.Activity204EntranceView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr2_9.instance = ActivityLiveMgr2_9.New()

return ActivityLiveMgr2_9
