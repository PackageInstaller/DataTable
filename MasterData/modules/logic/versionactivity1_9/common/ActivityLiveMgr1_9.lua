-- chunkname: @modules/logic/versionactivity1_9/common/ActivityLiveMgr1_9.lua

module("modules.logic.versionactivity1_9.common.ActivityLiveMgr1_9", package.seeall)

local ActivityLiveMgr1_9 = class("ActivityLiveMgr1_9")

function ActivityLiveMgr1_9:init()
	return
end

function ActivityLiveMgr1_9:getActId2ViewList()
	return {
		[VersionActivity1_9Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_9EnterView
		},
		[VersionActivity1_9Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_9StoreView
		},
		[VersionActivity1_9Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_9TaskView
		},
		[VersionActivity1_9Enum.ActivityId.ToughBattle] = {
			ViewName.ToughBattleActEnterView,
			ViewName.ToughBattleActMapView,
			ViewName.ToughBattleActLoadingView
		}
	}
end

ActivityLiveMgr1_9.instance = ActivityLiveMgr1_9.New()

return ActivityLiveMgr1_9
