-- chunkname: @modules/logic/pickassist/define/PickAssistEnum.lua

module("modules.logic.pickassist.define.PickAssistEnum", package.seeall)

local PickAssistEnum = _M

PickAssistEnum.Type = {
	Activity128General = 11,
	Activity166 = 4,
	Activity123 = 2,
	Rouge = 3,
	Survival = 5,
	TowerCompose2 = 7,
	TowerCompose1 = 6,
	BossRushActMode = 8,
	Normal = 1
}
PickAssistEnum.EpisdoeTypeAssistType = {
	[DungeonEnum.EpisodeType.V3_2ZongMao] = PickAssistEnum.Type.Activity128General
}

return PickAssistEnum
