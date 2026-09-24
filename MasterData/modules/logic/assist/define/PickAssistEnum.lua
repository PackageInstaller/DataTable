-- chunkname: @modules/logic/assist/define/PickAssistEnum.lua

module("modules.logic.assist.define.PickAssistEnum", package.seeall)

local PickAssistEnum = _M

PickAssistEnum.Type = {
	Activity128General = 11,
	Activity166 = 4,
	Activity128 = 8,
	Tower = 10,
	Survival = 5,
	Rouge = 3,
	TowerCompose2 = 13,
	TowerComposeSupport1 = 6,
	Activity123 = 2,
	Activity229 = 12,
	TowerComposeSupport2 = 7,
	TowerCompose = 9,
	Normal = 1
}
PickAssistEnum.EpisdoeTypeAssistType = {
	[DungeonEnum.EpisodeType.V3_2ZongMao] = PickAssistEnum.Type.Activity128General,
	[DungeonEnum.EpisodeType.TowerPermanent] = PickAssistEnum.Type.Tower,
	[DungeonEnum.EpisodeType.TowerBoss] = PickAssistEnum.Type.Tower,
	[DungeonEnum.EpisodeType.TowerDeep] = PickAssistEnum.Type.Tower,
	[DungeonEnum.EpisodeType.TowerCompose] = PickAssistEnum.Type.TowerCompose,
	[DungeonEnum.EpisodeType.Abyss] = PickAssistEnum.Type.Activity229
}

return PickAssistEnum
