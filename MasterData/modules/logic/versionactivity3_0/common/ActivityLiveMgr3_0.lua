-- chunkname: @modules/logic/versionactivity3_0/common/ActivityLiveMgr3_0.lua

module("modules.logic.versionactivity3_0.common.ActivityLiveMgr3_0", package.seeall)

local ActivityLiveMgr3_0 = class("ActivityLiveMgr3_0")

function ActivityLiveMgr3_0:init()
	return
end

function ActivityLiveMgr3_0:getActId2ViewList()
	return {
		[VersionActivity3_0Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_0EnterView
		},
		[VersionActivity3_0Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity3_0Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_8TaskView
		},
		[VersionActivity3_0Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		},
		[VersionActivity3_0Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		}
	}
end

function ActivityLiveMgr3_0:getActIdCheckCloseList()
	return {
		[VersionActivity3_0Enum.ActivityId.Dungeon] = DungeonController.closePreviewChapterDungeonMapViewActEnd
	}
end

ActivityLiveMgr3_0.instance = ActivityLiveMgr3_0.New()

return ActivityLiveMgr3_0
