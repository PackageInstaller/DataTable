-- chunkname: @modules/logic/versionactivity3_3/common/ActivityLiveMgr3_3.lua

module("modules.logic.versionactivity3_3.common.ActivityLiveMgr3_3", package.seeall)

local ActivityLiveMgr3_3 = class("ActivityLiveMgr3_3")

function ActivityLiveMgr3_3:init()
	return
end

function ActivityLiveMgr3_3:getActId2ViewList()
	return {
		[VersionActivity3_3Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_3EnterView
		},
		[VersionActivity3_3Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity3_3Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_8TaskView
		},
		[VersionActivity3_3Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		}
	}
end

function ActivityLiveMgr3_3:getActIdCheckCloseList()
	return {
		[VersionActivity3_3Enum.ActivityId.Dungeon] = DungeonController.closePreviewChapterDungeonMapViewActEnd
	}
end

ActivityLiveMgr3_3.instance = ActivityLiveMgr3_3.New()

return ActivityLiveMgr3_3
