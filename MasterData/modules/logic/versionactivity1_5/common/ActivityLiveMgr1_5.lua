-- chunkname: @modules/logic/versionactivity1_5/common/ActivityLiveMgr1_5.lua

module("modules.logic.versionactivity1_5.common.ActivityLiveMgr1_5", package.seeall)

local ActivityLiveMgr1_5 = class("ActivityLiveMgr1_5")

function ActivityLiveMgr1_5:init()
	return
end

function ActivityLiveMgr1_5:getActId2ViewList()
	return {
		[VersionActivity1_5Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_5EnterView
		},
		[VersionActivity1_5Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_5DungeonMapView,
			ViewName.VersionActivity1_5TaskView,
			ViewName.VersionActivity1_5DungeonMapLevelView
		},
		[VersionActivity1_5Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_5StoreView,
			ViewName.VersionActivity1_5NormalStoreGoodsView
		},
		[VersionActivity1_5Enum.ActivityId.Activity142] = {
			ViewName.Activity142MapView,
			ViewName.Activity142TaskView,
			ViewName.Activity142CollectView,
			ViewName.Activity142StoryView,
			ViewName.Activity142GameView,
			ViewName.Activity142GetCollectionView,
			ViewName.Activity142ResultView
		},
		[VersionActivity1_5Enum.ActivityId.PeaceUlu] = {
			ViewName.PeaceUluView,
			ViewName.PeaceUluMainView,
			ViewName.PeaceUluGameView,
			ViewName.PeaceUluResultView
		},
		[VersionActivity1_5Enum.ActivityId.AiZiLa] = {
			ViewName.AiZiLaMapView,
			ViewName.AiZiLaGameView,
			ViewName.AiZiLaGameResultView,
			ViewName.AiZiLaGameOpenEffectView,
			ViewName.AiZiLaTaskView
		}
	}
end

ActivityLiveMgr1_5.instance = ActivityLiveMgr1_5.New()

return ActivityLiveMgr1_5
