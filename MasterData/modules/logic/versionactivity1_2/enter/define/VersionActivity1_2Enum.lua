-- chunkname: @modules/logic/versionactivity1_2/enter/define/VersionActivity1_2Enum.lua

module("modules.logic.versionactivity1_2.enter.define.VersionActivity1_2Enum", package.seeall)

local VersionActivity1_2Enum = _M

VersionActivity1_2Enum.ActivityId = {
	DungeonStore = 11207,
	Dungeon = 11208,
	Season = 11200,
	Trade = 11205,
	Building = 11204,
	DreamTail = 11206,
	JieXiKa = 11202,
	YaXian = 11203,
	EnterView = 11201
}
VersionActivity1_2Enum.EnterViewActIdList = {
	VersionActivity1_2Enum.ActivityId.Trade,
	VersionActivity1_2Enum.ActivityId.JieXiKa,
	VersionActivity1_2Enum.ActivityId.Season,
	VersionActivity1_2Enum.ActivityId.Dungeon,
	VersionActivity1_2Enum.ActivityId.YaXian,
	VersionActivity1_2Enum.ActivityId.DreamTail
}

return VersionActivity1_2Enum
