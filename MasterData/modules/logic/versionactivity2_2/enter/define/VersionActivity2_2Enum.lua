-- chunkname: @modules/logic/versionactivity2_2/enter/define/VersionActivity2_2Enum.lua

module("modules.logic.versionactivity2_2.enter.define.VersionActivity2_2Enum", package.seeall)

local VersionActivity2_2Enum = _M

VersionActivity2_2Enum.ActivityId = {
	BossRush = 12209,
	TurnBackInvitation = 12222,
	RoleStory1 = 12207,
	Lopera = 12204,
	Season = 12210,
	BPSP = 12243,
	Eliminate = 12211,
	Dungeon = 12202,
	RoleStory2 = 12208,
	DungeonStore = 12205,
	RoomCritter = 12212,
	TianShiNaNa = 12203,
	LimitDecorate = 12236,
	EnterView = 12201
}
VersionActivity2_2Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_2Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_2Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.TianShiNaNa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_2Enum.ActivityId.TianShiNaNa
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.Eliminate,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_2Enum.ActivityId.RoleStory1,
			VersionActivity2_2Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.Lopera,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_2Enum.ActivityId.Lopera
	},
	{
		actId = VersionActivity2_2Enum.ActivityId.RoomCritter,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity2_2Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_2Enum.ActivityId.Dungeon,
	VersionActivity2_2Enum.ActivityId.BossRush,
	VersionActivity2_2Enum.ActivityId.Season,
	VersionActivity2_2Enum.ActivityId.TurnBackInvitation
}
VersionActivity2_2Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_2Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a2_mainactivity_singlebg/v2a2_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_2Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a2_mainactivity_singlebg/v2a2_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity2_2Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_2Enum.RedDotOffsetY = 56

return VersionActivity2_2Enum
