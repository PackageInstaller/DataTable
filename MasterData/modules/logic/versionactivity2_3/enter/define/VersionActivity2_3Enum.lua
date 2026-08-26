-- chunkname: @modules/logic/versionactivity2_3/enter/define/VersionActivity2_3Enum.lua

module("modules.logic.versionactivity2_3.enter.define.VersionActivity2_3Enum", package.seeall)

local VersionActivity2_3Enum = _M

VersionActivity2_3Enum.ActivityId = {
	Dungeon = 12302,
	Act174Store = 12319,
	ZhiXinQuanEr = 12306,
	RoleStory1 = 12307,
	Season = 12315,
	SeasonStore = 12316,
	Act174 = 12304,
	Tower = 12320,
	DungeonStore = 12303,
	BossRush = 12313,
	DuDuGu = 12305,
	EnterView = 12301
}
VersionActivity2_3Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_3Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_3Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_3Enum.ActivityId.Act174,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_3Enum.ActivityId.DuDuGu,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_3Enum.ActivityId.DuDuGu
	},
	{
		actId = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	},
	{
		actId = VersionActivity2_3Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_3Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity2_3Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_3Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = ActivityEnum.Activity.WeekWalkDeepShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkDeepShow
	},
	{
		actId = ActivityEnum.Activity.Tower,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity2_3Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_3Enum.ActivityId.Dungeon,
	VersionActivity2_3Enum.ActivityId.Season
}
VersionActivity2_3Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_3Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a3_mainactivity_singlebg/v2a3_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_3Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a3_mainactivity_singlebg/v2a3_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_3Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_3Enum.RedDotOffsetY = 56

return VersionActivity2_3Enum
