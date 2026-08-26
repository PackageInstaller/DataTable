-- chunkname: @modules/logic/versionactivity2_2/common/ActivityLiveMgr2_2.lua

module("modules.logic.versionactivity2_2.common.ActivityLiveMgr2_2", package.seeall)

local ActivityLiveMgr2_2 = class("ActivityLiveMgr2_2")

function ActivityLiveMgr2_2:init()
	return
end

function ActivityLiveMgr2_2:getActId2ViewList()
	return {
		[VersionActivity2_2Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_2EnterView
		},
		[VersionActivity2_2Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_2StoreView
		},
		[VersionActivity2_2Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_2TaskView
		},
		[VersionActivity2_2Enum.ActivityId.TianShiNaNa] = {
			ViewName.TianShiNaNaMainView,
			ViewName.TianShiNaNaLevelView
		},
		[VersionActivity2_2Enum.ActivityId.Lopera] = {
			ViewName.LoperaMainView,
			ViewName.LoperaLevelView
		},
		[VersionActivity2_2Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

ActivityLiveMgr2_2.instance = ActivityLiveMgr2_2.New()

return ActivityLiveMgr2_2
