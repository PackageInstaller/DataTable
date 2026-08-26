-- chunkname: @modules/logic/versionactivity2_6/common/ActivityLiveMgr2_6.lua

module("modules.logic.versionactivity2_6.common.ActivityLiveMgr2_6", package.seeall)

local ActivityLiveMgr2_6 = class("ActivityLiveMgr2_6")

function ActivityLiveMgr2_6:init()
	return
end

function ActivityLiveMgr2_6:getActId2ViewList()
	return {
		[VersionActivity2_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_6EnterView
		},
		[VersionActivity2_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_6StoreView
		},
		[VersionActivity2_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_6TaskView
		},
		[VersionActivity2_6Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

ActivityLiveMgr2_6.instance = ActivityLiveMgr2_6.New()

return ActivityLiveMgr2_6
