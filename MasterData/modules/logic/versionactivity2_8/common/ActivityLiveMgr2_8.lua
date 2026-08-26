-- chunkname: @modules/logic/versionactivity2_8/common/ActivityLiveMgr2_8.lua

module("modules.logic.versionactivity2_8.common.ActivityLiveMgr2_8", package.seeall)

local ActivityLiveMgr2_8 = class("ActivityLiveMgr2_8")

function ActivityLiveMgr2_8:init()
	return
end

function ActivityLiveMgr2_8:getActId2ViewList()
	return {
		[VersionActivity2_8Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_8EnterView
		},
		[VersionActivity2_8Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity2_8Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_8TaskView,
			ViewName.DungeonMapView
		},
		[VersionActivity2_8Enum.ActivityId.DungeonBoss] = {
			ViewName.VersionActivity2_8BossActEnterView
		},
		[VersionActivity2_8Enum.ActivityId.Survival] = {
			ViewName.SurvivalMainView,
			ViewName.SurvivalMapView
		},
		[VersionActivity2_8Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

function ActivityLiveMgr2_8:getActIdCheckCloseList()
	return {
		[VersionActivity2_8Enum.ActivityId.Dungeon] = DungeonController.closePreviewChapterDungeonMapViewActEnd
	}
end

ActivityLiveMgr2_8.instance = ActivityLiveMgr2_8.New()

return ActivityLiveMgr2_8
