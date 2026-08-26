-- chunkname: @modules/logic/versionactivity1_2/common/ActivityLiveMgr1_2.lua

module("modules.logic.versionactivity1_2.common.ActivityLiveMgr1_2", package.seeall)

local ActivityLiveMgr1_2 = class("ActivityLiveMgr1_2")

function ActivityLiveMgr1_2:init()
	return
end

function ActivityLiveMgr1_2:getActId2ViewList()
	return {
		[VersionActivity1_2Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_2EnterView
		},
		[VersionActivity1_2Enum.ActivityId.JieXiKa] = {
			ViewName.Activity114View
		},
		[VersionActivity1_2Enum.ActivityId.YaXian] = {
			ViewName.YaXianMapView,
			ViewName.YaXianGameView
		},
		[VersionActivity1_2Enum.ActivityId.Trade] = {
			ViewName.ActivityTradeBargain
		},
		[VersionActivity1_2Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_2DungeonView
		},
		[VersionActivity1_2Enum.ActivityId.DreamTail] = {
			ViewName.Activity119View
		},
		[VersionActivity1_2Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_2StoreView
		}
	}
end

ActivityLiveMgr1_2.instance = ActivityLiveMgr1_2.New()

return ActivityLiveMgr1_2
