-- chunkname: @modules/logic/versionactivity1_5/enter/define/VersionActivity1_5Enum.lua

module("modules.logic.versionactivity1_5.enter.define.VersionActivity1_5Enum", package.seeall)

local VersionActivity1_5Enum = _M

VersionActivity1_5Enum.ActivityId = {
	EnterView2 = 11517,
	DungeonExploreTask = 11505,
	DungeonStore = 11503,
	SportsNews = 11510,
	Season = 11500,
	SeasonStore = 11512,
	BossRush = 11516,
	PeaceUlu = 11507,
	DungeonBuilding = 11506,
	Dungeon = 11502,
	Activity142 = 11508,
	AiZiLa = 11509,
	EnterView = 11501
}
VersionActivity1_5Enum.EnterViewActIdListWithGroup = {
	[VersionActivity1_5Enum.ActivityId.EnterView] = {
		VersionActivity1_5Enum.ActivityId.Activity142,
		VersionActivity1_5Enum.ActivityId.BossRush,
		VersionActivity1_5Enum.ActivityId.SportsNews,
		VersionActivity1_5Enum.ActivityId.DungeonStore,
		VersionActivity1_5Enum.ActivityId.Dungeon
	},
	[VersionActivity1_5Enum.ActivityId.EnterView2] = {
		VersionActivity1_5Enum.ActivityId.PeaceUlu,
		VersionActivity1_5Enum.ActivityId.BossRush,
		VersionActivity1_5Enum.ActivityId.Season,
		VersionActivity1_5Enum.ActivityId.AiZiLa,
		VersionActivity1_5Enum.ActivityId.DungeonStore,
		VersionActivity1_5Enum.ActivityId.Dungeon
	}
}
VersionActivity1_5Enum.EnterViewMainActIdList = {
	VersionActivity1_5Enum.ActivityId.EnterView,
	VersionActivity1_5Enum.ActivityId.EnterView2
}
VersionActivity1_5Enum.ActId2Ambient = {
	[VersionActivity1_5Enum.ActivityId.EnterView] = 20150002,
	[VersionActivity1_5Enum.ActivityId.EnterView2] = 20150004
}
VersionActivity1_5Enum.ActId2OpenAudio = {
	[VersionActivity1_5Enum.ActivityId.EnterView] = 20150001,
	[VersionActivity1_5Enum.ActivityId.EnterView2] = 20150003
}

return VersionActivity1_5Enum
