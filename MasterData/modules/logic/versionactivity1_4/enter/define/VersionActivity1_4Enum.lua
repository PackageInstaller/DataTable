-- chunkname: @modules/logic/versionactivity1_4/enter/define/VersionActivity1_4Enum.lua

module("modules.logic.versionactivity1_4.enter.define.VersionActivity1_4Enum", package.seeall)

local VersionActivity1_4Enum = _M

VersionActivity1_4Enum.ActivityId = {
	Dungeon = 11407,
	Task = 11408,
	Role6 = 11403,
	Collect = 11409,
	Season = 11400,
	ShipRepair = 11419,
	SecondEnter = 11420,
	DustyRecords = 11424,
	BossRush = 11414,
	DungeonStore = 11406,
	Role37 = 11402,
	SeasonStore = 11410,
	EnterView = 11401,
	LimitFirstFall = 11421
}
VersionActivity1_4Enum.EnterViewActIdList = {
	VersionActivity1_4Enum.ActivityId.ShipRepair,
	VersionActivity1_4Enum.ActivityId.Role37,
	VersionActivity1_4Enum.ActivityId.BossRush,
	VersionActivity1_4Enum.ActivityId.Task,
	VersionActivity1_4Enum.ActivityId.DungeonStore,
	VersionActivity1_4Enum.ActivityId.Dungeon,
	VersionActivity1_4Enum.ActivityId.BossRush,
	VersionActivity1_4Enum.ActivityId.Season,
	VersionActivity1_4Enum.ActivityId.DustyRecords,
	VersionActivity1_4Enum.ActivityId.Role6,
	VersionActivity1_4Enum.ActivityId.DungeonStore,
	VersionActivity1_4Enum.ActivityId.Dungeon
}
VersionActivity1_4Enum.TabEnum = {
	Second = 2,
	First = 1
}
VersionActivity1_4Enum.TabActivityList = {
	[VersionActivity1_4Enum.TabEnum.First] = {
		1,
		2,
		3,
		4,
		5,
		6
	},
	[VersionActivity1_4Enum.TabEnum.Second] = {
		7,
		8,
		9,
		10,
		11,
		12
	}
}

return VersionActivity1_4Enum
