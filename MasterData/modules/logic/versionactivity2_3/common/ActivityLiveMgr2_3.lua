-- chunkname: @modules/logic/versionactivity2_3/common/ActivityLiveMgr2_3.lua

module("modules.logic.versionactivity2_3.common.ActivityLiveMgr2_3", package.seeall)

local ActivityLiveMgr2_3 = class("ActivityLiveMgr2_3")

function ActivityLiveMgr2_3:init()
	return
end

function ActivityLiveMgr2_3:getActId2ViewList()
	return {
		[VersionActivity2_3Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_3EnterView
		},
		[VersionActivity2_3Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_3StoreView
		},
		[VersionActivity2_3Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_3TaskView
		},
		[VersionActivity2_3Enum.ActivityId.DuDuGu] = {
			ViewName.DuDuGuLevelView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr2_3.instance = ActivityLiveMgr2_3.New()

return ActivityLiveMgr2_3
