-- chunkname: @modules/logic/versionactivity3_9/common/ActivityLiveMgr3_9.lua

module("modules.logic.versionactivity3_9.common.ActivityLiveMgr3_9", package.seeall)

local ActivityLiveMgr3_9 = class("ActivityLiveMgr3_9")

function ActivityLiveMgr3_9:init()
	return
end

function ActivityLiveMgr3_9:getActId2ViewList()
	return {
		[VersionActivity3_9Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_9EnterView
		},
		[VersionActivity3_9Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_9StoreView
		},
		[VersionActivity3_9Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_9TaskView,
			ViewName.VersionActivity3_9DungeonMapView
		},
		[VersionActivity3_9Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity3_2DungeonMapView,
			ViewName.VersionActivity3_2DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity3_9Enum.ActivityId.Hedone] = {
			ViewName.HedoneLevelView,
			ViewName.HedoneTaskView,
			ViewName.HedoneGameView,
			ViewName.HedoneResultView
		},
		[VersionActivity3_9Enum.ActivityId.Naxisuosi] = {
			ViewName.NaxisuosiLevelView,
			ViewName.NaxisuosiTaskView
		},
		[VersionActivity3_9Enum.ActivityId.Racing] = {
			ViewName.V3a9RacingCarGameView,
			ViewName.V3a9RacingCarMainView
		},
		[VersionActivity3_9Enum.ActivityId.Bird] = {
			ViewName.V3a9BirdGameView,
			ViewName.V3a9BirdMainView,
			ViewName.V3a9BirdLoadingView,
			ViewName.V3a9BirdResultView,
			ViewName.V3a9BirdPauseView
		},
		[VersionActivity3_9Enum.ActivityId.V3a9BossRushAct] = {
			ViewName.V3a9_BossRush_HeroGroupFightView,
			ViewName.V3a9_BossRush_LevelDetailView,
			ViewName.V3a9_BossRush_HeroGroupEditView
		}
	}
end

ActivityLiveMgr3_9.instance = ActivityLiveMgr3_9.New()

return ActivityLiveMgr3_9
