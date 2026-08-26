-- chunkname: @modules/logic/versionactivity1_7/common/ActivityLiveMgr1_7.lua

module("modules.logic.versionactivity1_7.common.ActivityLiveMgr1_7", package.seeall)

local ActivityLiveMgr1_7 = class("ActivityLiveMgr1_7")

function ActivityLiveMgr1_7:init()
	return
end

function ActivityLiveMgr1_7:getActId2ViewList()
	return {
		[VersionActivity1_7Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_7EnterView
		},
		[VersionActivity1_7Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_7StoreView
		},
		[VersionActivity1_7Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_7TaskView
		},
		[VersionActivity1_7Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity1_7Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_2DungeonView,
			ViewName.ReactivityTaskView,
			ViewName.ReactivityRuleView
		}
	}
end

ActivityLiveMgr1_7.instance = ActivityLiveMgr1_7.New()

return ActivityLiveMgr1_7
