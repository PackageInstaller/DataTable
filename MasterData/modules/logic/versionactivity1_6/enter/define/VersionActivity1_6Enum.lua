-- chunkname: @modules/logic/versionactivity1_6/enter/define/VersionActivity1_6Enum.lua

module("modules.logic.versionactivity1_6.enter.define.VersionActivity1_6Enum", package.seeall)

local VersionActivity1_6Enum = _M

VersionActivity1_6Enum.ActivityId = {
	Role1 = 11605,
	BossRush = 11604,
	DungeonBossRush = 11609,
	Cachot = 11610,
	Season = 11600,
	Reactivity = 11104,
	Role2 = 11606,
	RoleStory = 11612,
	DungeonSkillTree = 11608,
	DungeonStore = 11603,
	Explore = 11617,
	Dungeon = 11602,
	RoleStory2 = 11620,
	SeasonStore = 11607,
	EnterView = 11601,
	ReactivityStore = 11611
}
VersionActivity1_6Enum.EnterViewActIdList = {
	VersionActivity1_6Enum.ActivityId.Dungeon,
	VersionActivity1_6Enum.ActivityId.Cachot,
	VersionActivity1_6Enum.ActivityId.Reactivity,
	VersionActivity1_6Enum.ActivityId.Role1,
	VersionActivity1_6Enum.ActivityId.Role2,
	VersionActivity1_6Enum.ActivityId.BossRush,
	VersionActivity1_6Enum.ActivityId.Season,
	{
		VersionActivity1_6Enum.ActivityId.RoleStory,
		VersionActivity1_6Enum.ActivityId.RoleStory2
	},
	VersionActivity1_6Enum.ActivityId.Explore
}

return VersionActivity1_6Enum
