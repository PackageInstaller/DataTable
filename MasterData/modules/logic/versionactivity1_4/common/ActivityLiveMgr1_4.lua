-- chunkname: @modules/logic/versionactivity1_4/common/ActivityLiveMgr1_4.lua

module("modules.logic.versionactivity1_4.common.ActivityLiveMgr1_4", package.seeall)

local ActivityLiveMgr1_4 = class("ActivityLiveMgr1_4")

function ActivityLiveMgr1_4:init()
	return
end

function ActivityLiveMgr1_4:getActId2ViewList()
	return {
		[VersionActivity1_4Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_4EnterView
		},
		[VersionActivity1_4Enum.ActivityId.Role37] = {
			ViewName.Activity130LevelView,
			ViewName.Activity130GameView,
			ViewName.Activity130DialogView,
			ViewName.Activity130CollectView,
			ViewName.Activity130TaskView
		},
		[VersionActivity1_4Enum.ActivityId.Role6] = {
			ViewName.Activity131LevelView,
			ViewName.Activity131GameView,
			ViewName.Activity131DialogView,
			ViewName.Activity131CollectView,
			ViewName.Activity131TaskView
		},
		[VersionActivity1_4Enum.ActivityId.ShipRepair] = {
			ViewName.Activity133View,
			ViewName.Activity133TaskView
		}
	}
end

ActivityLiveMgr1_4.instance = ActivityLiveMgr1_4.New()

return ActivityLiveMgr1_4
