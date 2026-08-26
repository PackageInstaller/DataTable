-- chunkname: @modules/logic/versionactivity2_0/enter/define/VersionActivity2_0Enum.lua

module("modules.logic.versionactivity2_0.enter.define.VersionActivity2_0Enum", package.seeall)

local VersionActivity2_0Enum = _M

VersionActivity2_0Enum.ActivityId = {
	EnterView = 12002,
	DungeonGraffiti = 12005,
	RoleStory1 = 12011,
	BossRush = 12013,
	Season = 12006,
	Joe = 12008,
	Reactivity = 11502,
	Mercuria = 12009,
	RoleStory2 = 12012,
	DungeonStore = 12004,
	Dungeon = 12003,
	SeasonStore = 12007,
	ReactivityStore = 12001
}
VersionActivity2_0Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_0Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_0Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_0Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_0Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity2_0Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_0Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity2_0Enum.ActivityId.Mercuria,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_0Enum.ActivityId.Mercuria
	},
	{
		actId = VersionActivity2_0Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_0Enum.ActivityId.Joe,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_0Enum.ActivityId.Joe
	},
	{
		actId = {
			VersionActivity2_0Enum.ActivityId.RoleStory1,
			VersionActivity2_0Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	}
}
VersionActivity2_0Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_0Enum.ActivityId.Dungeon,
	VersionActivity2_0Enum.ActivityId.BossRush,
	VersionActivity2_0Enum.ActivityId.Season
}
VersionActivity2_0Enum.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[VersionActivity2_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[VersionActivity2_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a0_mainactivity_singlebg/v2a0_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_0Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_0Enum.RedDotOffsetY = 56
VersionActivity2_0Enum.EnterAnimVideoPath = "videos/1_9_enter.mp4"

function VersionActivity2_0Enum.JumpNeedCloseView()
	return {
		ViewName.VersionActivity2_0DungeonGraffitiView,
		ViewName.VersionActivity2_0DungeonMapGraffitiEnterView,
		ViewName.VersionActivity2_0DungeonMapView
	}
end

return VersionActivity2_0Enum
