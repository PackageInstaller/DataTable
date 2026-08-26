-- chunkname: @modules/logic/versionactivity/common/ActivityLiveMgr1_1.lua

module("modules.logic.versionactivity.common.ActivityLiveMgr1_1", package.seeall)

local ActivityLiveMgr1_1 = class("ActivityLiveMgr1_1")

function ActivityLiveMgr1_1:init()
	return
end

function ActivityLiveMgr1_1:getActId2ViewList()
	return {
		[VersionActivityEnum.ActivityId.Act105] = {
			ViewName.VersionActivityEnterView
		},
		[VersionActivityEnum.ActivityId.Act113] = {
			ViewName.VersionActivityMainView,
			ViewName.VersionActivityNewsView,
			ViewName.VersionActivityPuzzleView,
			ViewName.VersionActivityDungeonMapView,
			ViewName.VersionActivityDungeonMapLevelView,
			ViewName.VersionActivityTaskView
		},
		[VersionActivityEnum.ActivityId.Act107] = {
			ViewName.VersionActivityStoreView
		},
		[VersionActivityEnum.ActivityId.Act104] = {
			ViewName.SeasonMainView
		},
		[VersionActivityEnum.ActivityId.Act108] = {
			ViewName.MeilanniMainView,
			ViewName.MeilanniView
		},
		[VersionActivityEnum.ActivityId.Act109] = {
			ViewName.Activity109ChessEntry,
			ViewName.ActivityChessGame
		},
		[VersionActivityEnum.ActivityId.Act111] = {
			ViewName.VersionActivityPushBoxLevelView,
			ViewName.VersionActivityPushBoxGameView
		},
		[VersionActivityEnum.ActivityId.Act112] = {
			ViewName.VersionActivityExchangeView
		},
		[VersionActivityEnum.ActivityId.Act106] = {
			ViewName.ActivityWarmUpGameView,
			ViewName.ActivityWarmUpView
		}
	}
end

ActivityLiveMgr1_1.instance = ActivityLiveMgr1_1.New()

return ActivityLiveMgr1_1
