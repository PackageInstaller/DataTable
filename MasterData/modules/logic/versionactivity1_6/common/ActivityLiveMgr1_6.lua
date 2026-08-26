-- chunkname: @modules/logic/versionactivity1_6/common/ActivityLiveMgr1_6.lua

module("modules.logic.versionactivity1_6.common.ActivityLiveMgr1_6", package.seeall)

local ActivityLiveMgr1_6 = class("ActivityLiveMgr1_6")

function ActivityLiveMgr1_6:init()
	return
end

function ActivityLiveMgr1_6:getActId2ViewList()
	return {
		[VersionActivity1_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_6EnterView
		},
		[VersionActivity1_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_6DungeonMapView,
			ViewName.VersionActivity1_6TaskView,
			ViewName.VersionActivity1_6DungeonMapLevelView,
			ViewName.VersionActivity1_6SkillView,
			ViewName.VersionActivity1_6DungeonBossView
		},
		[VersionActivity1_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_6StoreView,
			ViewName.VersionActivity1_6NormalStoreGoodsView
		},
		[VersionActivity1_6Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivityMainView,
			ViewName.VersionActivityNewsView,
			ViewName.VersionActivityPuzzleView,
			ViewName.VersionActivityDungeonMapView,
			ViewName.VersionActivityDungeonMapLevelView,
			ViewName.ReactivityTaskView,
			ViewName.ReactivityRuleView
		},
		[VersionActivity1_6Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity1_6Enum.ActivityId.Cachot] = {
			ViewName.V1a6_CachotMainView,
			ViewName.V1a6_CachotRoomView,
			ViewName.V1a6_CachotRewardView,
			ViewName.V1a6_CachotEndingView,
			ViewName.V1a6_CachotFinishView,
			ViewName.V1a6_CachotStoreView,
			ViewName.V1a6_CachotRewardView,
			ViewName.V1a6_CachotEpisodeView,
			ViewName.V1a6_CachotInteractView,
			ViewName.V1a6_CachotCollectionSelectView,
			ViewName.V1a6_CachotUpgradeView,
			ViewName.V1a6_CachotRoleRecoverView,
			ViewName.V1a6_CachotRoleRevivalView,
			ViewName.V1a6_CachotTipsView
		},
		[VersionActivity1_6Enum.ActivityId.Season] = SeasonViewHelper.getAllSeasonViewList(Activity104Model.instance:getCurSeasonId()),
		[VersionActivity1_6Enum.ActivityId.SeasonStore] = {
			SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.StoreView)
		}
	}
end

ActivityLiveMgr1_6.instance = ActivityLiveMgr1_6.New()

return ActivityLiveMgr1_6
