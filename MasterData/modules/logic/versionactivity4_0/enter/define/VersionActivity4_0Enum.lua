-- chunkname: @modules/logic/versionactivity4_0/enter/define/VersionActivity4_0Enum.lua

module("modules.logic.versionactivity4_0.enter.define.VersionActivity4_0Enum", package.seeall)

local VersionActivity4_0Enum = _M

VersionActivity4_0Enum.ActivityId = {
	MatchGame = 14012,
	SpLilya = 14013,
	Deleike = 14014,
	RoleStory = 14028,
	ConcertLimitMain = 14020,
	AutoChess = 14011,
	ConcertMusicGame = 14022,
	DungeonStore = 14003,
	ConcertSelfSelect = 14024,
	Dungeon = 14002,
	ConcertActFlip = 14023,
	ConcertCandyRoom = 14021,
	EnterView = 14001
}
VersionActivity4_0Enum.CharacterActId = {
	[VersionActivity4_0Enum.ActivityId.SpLilya] = true,
	[VersionActivity4_0Enum.ActivityId.Deleike] = true
}
VersionActivity4_0Enum.EnterViewActSetting = {
	{
		actId = VersionActivity4_0Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity4_0Enum.ActivityId.DungeonStore
	},
	{
		actId = BossRushConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_0Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_0Enum.ActivityId.MatchGame,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_0Enum.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_0Enum.ActivityId.SpLilya,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity4_0Enum.ActivityId.Deleike,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
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
	},
	{
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	},
	{
		actId = AbyssConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity4_0Enum.EnterViewActIdListWithRedDot = {
	VersionActivity4_0Enum.ActivityId.Dungeon
}
VersionActivity4_0Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#E3DED3",
		enFontSize = 16,
		enColor = "#FFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity4_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v4a0_mainactivity_singlebg/v4a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#B4B4B4",
		enFontSize = 16,
		enColor = "#B4B4B4",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity4_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v4a0_mainactivity_singlebg/v4a0_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity4_0Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity4_0Enum.RedDotOffsetY = 160
VersionActivity4_0Enum.RedDotOffsetX = 10
VersionActivity4_0Enum.EnterLoopVideoName = "v4a0_kv_loop"
VersionActivity4_0Enum.EnterAnimVideoName = "v4a0_kv_open"
VersionActivity4_0Enum.EnterVideoDayKey = "v4a0_EnterVideoDayKey"
VersionActivity4_0Enum.EnterVideoFirstKey = "v4a0_EnterVideoFirstKey"
VersionActivity4_0Enum.OpenAnimDelayTime = 7.2

return VersionActivity4_0Enum
