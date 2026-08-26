-- chunkname: @modules/logic/sp02/enter/define/VersionActivity3_10Enum.lua

module("modules.logic.sp02.enter.define.VersionActivity3_10Enum", package.seeall)

local VersionActivity3_10Enum = _M

VersionActivity3_10Enum.ActivityId = {
	Abyss = 138521,
	DungeonStore = 138503,
	Outside = 138507,
	Dungeon = 138502,
	EnterView = 138501
}
VersionActivity3_10Enum.EnterViewActIdList = {
	VersionActivity3_10Enum.ActivityId.Dungeon,
	VersionActivity3_10Enum.ActivityId.DungeonStore,
	VersionActivity3_10Enum.ActivityId.Outside,
	BossRushConfig.instance:getActivityId(),
	VersionActivity3_10Enum.ActivityId.Abyss
}
VersionActivity3_10Enum.ActId2Ambient = {
	[VersionActivity3_10Enum.ActivityId.EnterView] = 3290001
}
VersionActivity3_10Enum.ActId2OpenAudio = {
	[VersionActivity3_10Enum.ActivityId.EnterView] = 20305301
}

return VersionActivity3_10Enum
