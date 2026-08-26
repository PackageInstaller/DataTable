-- chunkname: @modules/logic/sp02/common/ActivityLiveMgr3_10.lua

module("modules.logic.sp02.common.ActivityLiveMgr3_10", package.seeall)

local ActivityLiveMgr3_10 = class("ActivityLiveMgr3_10")

function ActivityLiveMgr3_10:init()
	return
end

function ActivityLiveMgr3_10:getActId2ViewList()
	return {
		[VersionActivity3_10Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_10EnterView
		},
		[VersionActivity3_10Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_10StoreView
		},
		[VersionActivity3_10Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_10TaskView,
			ViewName.VersionActivity3_10DungeonMapView
		},
		[VersionActivity3_10Enum.ActivityId.Outside] = {
			ViewName.AtomicDungeonMainView
		},
		[VersionActivity3_10Enum.ActivityId.Abyss] = {
			ViewName.AbyssMainView
		}
	}
end

ActivityLiveMgr3_10.instance = ActivityLiveMgr3_10.New()

return ActivityLiveMgr3_10
