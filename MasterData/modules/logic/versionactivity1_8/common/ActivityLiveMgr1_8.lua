-- chunkname: @modules/logic/versionactivity1_8/common/ActivityLiveMgr1_8.lua

module("modules.logic.versionactivity1_8.common.ActivityLiveMgr1_8", package.seeall)

local ActivityLiveMgr1_8 = class("ActivityLiveMgr1_8")

function ActivityLiveMgr1_8:init()
	return
end

function ActivityLiveMgr1_8:getActId2ViewList()
	return {
		[VersionActivity1_8Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_8EnterView
		},
		[VersionActivity1_8Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_8DungeonMapView,
			ViewName.VersionActivity1_8TaskView,
			ViewName.VersionActivity1_8DungeonMapLevelView,
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		},
		[VersionActivity1_8Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_8StoreView,
			ViewName.VersionActivity1_6NormalStoreGoodsView
		},
		[VersionActivity1_8Enum.ActivityId.DungeonReturnToWork] = {
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		}
	}
end

ActivityLiveMgr1_8.instance = ActivityLiveMgr1_8.New()

return ActivityLiveMgr1_8
