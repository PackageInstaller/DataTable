-- chunkname: @modules/logic/versionactivity1_8/enter/define/VersionActivity1_8Enum.lua

module("modules.logic.versionactivity1_8.enter.define.VersionActivity1_8Enum", package.seeall)

local VersionActivity1_8Enum = _M

VersionActivity1_8Enum.ActivityId = {
	ReactivityStore = 11802,
	DungeonReturnToWork = 11815,
	RoleStory1 = 11813,
	WindSong = 11807,
	Season = 11811,
	BossRush = 11812,
	Reactivity = 11302,
	Weila = 11806,
	RoleStory2 = 11814,
	DungeonStore = 11805,
	JustReport = 11810,
	Dungeon = 11804,
	SeasonStore = 11816,
	EnterView = 11803
}
VersionActivity1_8Enum.EnterViewActSetting = {
	{
		actId = VersionActivity1_8Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity1_8Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity1_8Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity1_8Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity1_8Enum.ActivityId.Weila,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity1_8Enum.ActivityId.Weila
	},
	{
		actId = VersionActivity1_8Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity1_8Enum.ActivityId.RoleStory1,
			VersionActivity1_8Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity1_8Enum.ActivityId.WindSong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity1_8Enum.ActivityId.WindSong
	},
	{
		actId = VersionActivity1_8Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity1_8Enum.ActivityId.SeasonStore
	}
}
VersionActivity1_8Enum.EnterViewActIdListWithRedDot = {
	VersionActivity1_8Enum.ActivityId.Dungeon,
	VersionActivity1_8Enum.ActivityId.Weila,
	VersionActivity1_8Enum.ActivityId.BossRush,
	VersionActivity1_8Enum.ActivityId.WindSong
}
VersionActivity1_8Enum.TabSetting = {
	select = {
		fontSize = 42,
		enFontSize = 14,
		color = Color(1, 1, 1, 1),
		act2TabImg = {
			[VersionActivity1_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		enFontSize = 14,
		color = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1),
		act2TabImg = {
			[VersionActivity1_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a8_mainactivity_singlebg/v1a8_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity1_8Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity1_8Enum.RedDotOffsetY = 56
VersionActivity1_8Enum.EnterAnimVideoPath = "videos/1_8_enter.mp4"

return VersionActivity1_8Enum
