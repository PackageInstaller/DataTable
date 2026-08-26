-- chunkname: @modules/logic/versionactivity3_6/common/ActivityLiveMgr3_6.lua

module("modules.logic.versionactivity3_6.common.ActivityLiveMgr3_6", package.seeall)

local ActivityLiveMgr3_6 = class("ActivityLiveMgr3_6")

function ActivityLiveMgr3_6:init()
	return
end

function ActivityLiveMgr3_6:getActId2ViewList()
	return {
		[VersionActivity3_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_6EnterView
		},
		[VersionActivity3_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_6StoreView
		},
		[VersionActivity3_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_6TaskView,
			ViewName.VersionActivity3_6DungeonMapView
		},
		[VersionActivity3_6Enum.ActivityId.Abyss] = {
			ViewName.AbyssEnterView
		},
		[VersionActivity3_6Enum.ActivityId.YaMi] = {
			ViewName.V3a6YaMiMainView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_6.instance = ActivityLiveMgr3_6.New()

return ActivityLiveMgr3_6
