-- chunkname: @modules/logic/versionactivity3_2/common/ActivityLiveMgr3_2.lua

module("modules.logic.versionactivity3_2.common.ActivityLiveMgr3_2", package.seeall)

local ActivityLiveMgr3_2 = class("ActivityLiveMgr3_2")

function ActivityLiveMgr3_2:init()
	return
end

function ActivityLiveMgr3_2:getActId2ViewList()
	return {
		[VersionActivity3_2Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_2EnterView
		},
		[VersionActivity3_2Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_2StoreView
		},
		[VersionActivity3_2Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_2TaskView,
			ViewName.VersionActivity3_2DungeonMapView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr3_2.instance = ActivityLiveMgr3_2.New()

return ActivityLiveMgr3_2
