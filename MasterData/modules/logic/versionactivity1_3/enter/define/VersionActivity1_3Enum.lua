-- chunkname: @modules/logic/versionactivity1_3/enter/define/VersionActivity1_3Enum.lua

module("modules.logic.versionactivity1_3.enter.define.VersionActivity1_3Enum", package.seeall)

local VersionActivity1_3Enum = _M

VersionActivity1_3Enum.ActivityId = {
	DungeonStore = 11303,
	Act310 = 11310,
	Act307 = 11307,
	Season = 11300,
	Act306 = 11306,
	Act305 = 11305,
	Dungeon = 11302,
	SeasonStore = 11308,
	EnterView = 11301,
	Act304 = 11304
}
VersionActivity1_3Enum.EnterViewActIdList = {
	VersionActivity1_3Enum.ActivityId.Act306,
	VersionActivity1_3Enum.ActivityId.Act307,
	VersionActivity1_3Enum.ActivityId.Season,
	VersionActivity1_3Enum.ActivityId.Dungeon,
	VersionActivity1_3Enum.ActivityId.Act305,
	VersionActivity1_3Enum.ActivityId.Act304
}

return VersionActivity1_3Enum
