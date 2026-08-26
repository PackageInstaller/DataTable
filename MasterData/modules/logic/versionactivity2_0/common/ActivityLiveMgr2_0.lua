-- chunkname: @modules/logic/versionactivity2_0/common/ActivityLiveMgr2_0.lua

module("modules.logic.versionactivity2_0.common.ActivityLiveMgr2_0", package.seeall)

local ActivityLiveMgr2_0 = class("ActivityLiveMgr2_0")

function ActivityLiveMgr2_0:init()
	return
end

function ActivityLiveMgr2_0:getActId2ViewList()
	return {
		[VersionActivity2_0Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_0EnterView
		},
		[VersionActivity2_0Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_0StoreView
		},
		[VersionActivity2_0Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_0TaskView,
			ViewName.VersionActivity2_0DungeonMapView,
			ViewName.VersionActivity2_0DungeonMapLevelView,
			ViewName.VersionActivity2_0DungeonMapGraffitiEnterView
		},
		[VersionActivity2_0Enum.ActivityId.DungeonGraffiti] = {
			ViewName.VersionActivity2_0DungeonGraffitiDrawView,
			ViewName.VersionActivity2_0DungeonGraffitiView
		}
	}
end

ActivityLiveMgr2_0.instance = ActivityLiveMgr2_0.New()

return ActivityLiveMgr2_0
