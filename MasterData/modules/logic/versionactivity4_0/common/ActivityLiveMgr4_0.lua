-- chunkname: @modules/logic/versionactivity4_0/common/ActivityLiveMgr4_0.lua

module("modules.logic.versionactivity4_0.common.ActivityLiveMgr4_0", package.seeall)

local ActivityLiveMgr4_0 = class("ActivityLiveMgr4_0")

function ActivityLiveMgr4_0:init()
	return
end

function ActivityLiveMgr4_0:getActId2ViewList()
	return {
		[VersionActivity4_0Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity4_0EnterView
		},
		[VersionActivity4_0Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity4_0StoreView
		},
		[VersionActivity4_0Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity4_0TaskView,
			ViewName.VersionActivity4_0DungeonMapView
		},
		[VersionActivity4_0Enum.ActivityId.SpLilya] = {
			ViewName.SpLilyaLevelView,
			ViewName.SpLilyaTaskView
		},
		[VersionActivity4_0Enum.ActivityId.MatchGame] = {
			ViewName.MatchGameEnterView,
			ViewName.MatchGameCharacterView,
			ViewName.MatchGameMapView,
			ViewName.MatchGameChallengeMapView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

ActivityLiveMgr4_0.instance = ActivityLiveMgr4_0.New()

return ActivityLiveMgr4_0
