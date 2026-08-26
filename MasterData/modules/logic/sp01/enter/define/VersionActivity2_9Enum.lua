-- chunkname: @modules/logic/sp01/enter/define/VersionActivity2_9Enum.lua

module("modules.logic.sp01.enter.define.VersionActivity2_9Enum", package.seeall)

local VersionActivity2_9Enum = _M

VersionActivity2_9Enum.ActivityId = {
	EnterView2 = 130506,
	Outside = 130504,
	Dungeon2 = 130507,
	BossRush = 130505,
	ReactivityStore = 130508,
	DungeonStore = 130503,
	Dungeon = 130502,
	EnterView = 130501,
	Reactivity = VersionActivity2_3Enum.ActivityId.Dungeon,
	V2a9_Act204 = ActivityEnum.Activity.V2a9_Act204,
	V2a9_Act205 = ActivityEnum.Activity.V2a9_Act205
}
VersionActivity2_9Enum.EnterViewActIdListWithGroup = {
	[VersionActivity2_9Enum.ActivityId.EnterView] = {
		VersionActivity2_9Enum.ActivityId.Outside,
		VersionActivity2_9Enum.ActivityId.BossRush,
		VersionActivity2_9Enum.ActivityId.DungeonStore,
		VersionActivity2_9Enum.ActivityId.Dungeon
	},
	[VersionActivity2_9Enum.ActivityId.EnterView2] = {
		VersionActivity2_9Enum.ActivityId.Outside,
		VersionActivity2_9Enum.ActivityId.DungeonStore,
		VersionActivity2_9Enum.ActivityId.Dungeon,
		VersionActivity2_9Enum.ActivityId.BossRush,
		VersionActivity2_9Enum.ActivityId.Dungeon2
	}
}
VersionActivity2_9Enum.EnterViewMainActIdList = {
	VersionActivity2_9Enum.ActivityId.EnterView,
	VersionActivity2_9Enum.ActivityId.EnterView2
}
VersionActivity2_9Enum.ActId2Ambient = {
	[VersionActivity2_9Enum.ActivityId.EnterView] = 3290001,
	[VersionActivity2_9Enum.ActivityId.EnterView2] = 3290002
}
VersionActivity2_9Enum.ActId2OpenAudio = {
	[VersionActivity2_9Enum.ActivityId.EnterView] = 20305301,
	[VersionActivity2_9Enum.ActivityId.EnterView2] = 20305301
}
VersionActivity2_9Enum.DelaySwitchBgTime = 2.01
VersionActivity2_9Enum.DelaySwitchHero2Idle = 2
VersionActivity2_9Enum.DelayPlayGroupBgm = 2.5
VersionActivity2_9Enum.NextGroupGuideId = 130501
VersionActivity2_9Enum.actId2GuideId = {
	[VersionActivity2_9Enum.ActivityId.EnterView2] = VersionActivity2_9Enum.NextGroupGuideId
}
VersionActivity2_9Enum.ActId2BgAudioName = {
	[VersionActivity2_9Enum.ActivityId.EnterView] = "sp01_kv_up",
	[VersionActivity2_9Enum.ActivityId.EnterView2] = "sp01_kv_down"
}

return VersionActivity2_9Enum
