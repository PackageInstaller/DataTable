-- chunkname: @modules/logic/versionactivity2_1/enter/define/VersionActivity2_1Enum.lua

module("modules.logic.versionactivity2_1.enter.define.VersionActivity2_1Enum", package.seeall)

local VersionActivity2_1Enum = _M

VersionActivity2_1Enum.ActivityId = {
	BossRush = 12113,
	DungeonStore = 12103,
	RoleStory1 = 12106,
	RoleStory2 = 12107,
	Season = 12115,
	StoryDeduction = 12104,
	Aergusi = 12105,
	RougeDlc1 = 12117,
	Dungeon = 12102,
	SeasonStore = 12116,
	EnterView = 12101,
	LanShouPa = 12114
}
VersionActivity2_1Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_1Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_1Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_1Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_1Enum.ActivityId.LanShouPa
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.Aergusi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_1Enum.ActivityId.Aergusi
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.RougeDlc1,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_1Enum.ActivityId.RougeDlc1
	},
	{
		actId = {
			VersionActivity2_1Enum.ActivityId.RoleStory1,
			VersionActivity2_1Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	}
}
VersionActivity2_1Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_1Enum.ActivityId.Dungeon,
	VersionActivity2_1Enum.ActivityId.BossRush,
	VersionActivity2_1Enum.ActivityId.Season
}
VersionActivity2_1Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a1_mainactivity_singlebg/v2a1_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a1_mainactivity_singlebg/v2a1_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_1Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_1Enum.RedDotOffsetY = 56

return VersionActivity2_1Enum
