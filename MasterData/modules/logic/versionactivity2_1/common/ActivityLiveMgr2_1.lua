-- chunkname: @modules/logic/versionactivity2_1/common/ActivityLiveMgr2_1.lua

module("modules.logic.versionactivity2_1.common.ActivityLiveMgr2_1", package.seeall)

local ActivityLiveMgr2_1 = class("ActivityLiveMgr2_1")

function ActivityLiveMgr2_1:init()
	return
end

function ActivityLiveMgr2_1:getActId2ViewList()
	return {
		[VersionActivity2_1Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_1EnterView
		},
		[VersionActivity2_1Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_1StoreView
		},
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = {
			ViewName.LanShouPaMapView,
			ViewName.LanShouPaGameView
		}
	}
end

ActivityLiveMgr2_1.instance = ActivityLiveMgr2_1.New()

return ActivityLiveMgr2_1
