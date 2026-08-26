-- chunkname: @modules/logic/versionactivity3_8/common/ActivityLiveMgr3_8.lua

module("modules.logic.versionactivity3_8.common.ActivityLiveMgr3_8", package.seeall)

local ActivityLiveMgr3_8 = class("ActivityLiveMgr3_8")

function ActivityLiveMgr3_8:init()
	return
end

function ActivityLiveMgr3_8:getActId2ViewList()
	return {
		[VersionActivity3_8Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_8EnterView
		},
		[VersionActivity3_8Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_8StoreView
		},
		[VersionActivity3_8Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_8TaskView,
			ViewName.VersionActivity3_8DungeonMapView
		},
		[VersionActivity3_8Enum.ActivityId.Abyss] = {
			ViewName.AbyssEnterView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_8.instance = ActivityLiveMgr3_8.New()

return ActivityLiveMgr3_8
