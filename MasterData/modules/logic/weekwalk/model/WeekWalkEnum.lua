-- chunkname: @modules/logic/weekwalk/model/WeekWalkEnum.lua

module("modules.logic.weekwalk.model.WeekWalkEnum", package.seeall)

local WeekWalkEnum = _M

WeekWalkEnum.ElementType = {
	Dialog = 4,
	General = 2,
	MaxCount = 4,
	Battle = 1,
	Respawn = 3
}
WeekWalkEnum.GeneralType = {
	Audio = 1,
	Bgm = 0
}
WeekWalkEnum.BuffType = {
	Pray = 3,
	Assist = 2,
	Special = 1
}
WeekWalkEnum.TaskType = {
	Week = 2,
	Challenge = 4,
	Dream = 3
}
WeekWalkEnum.SacrificeEffectType = {
	ExAttr = 2,
	PassiveSkill = 3,
	BaseAttr = 1
}
WeekWalkEnum.ShallowMapIds = {
	[204] = true,
	[202] = true,
	[104] = true,
	[205] = true,
	[101] = true,
	[102] = true,
	[201] = true,
	[103] = true,
	[105] = true,
	[203] = true
}
WeekWalkEnum.episodeId = 90101
WeekWalkEnum.MaxLevel = 2
WeekWalkEnum.SevenDaySec = 604800
WeekWalkEnum.orthographicSize = 5
WeekWalkEnum.FirstDeepLayer = 11
WeekWalkEnum.OneDeepLayerFirstBattle = 1
WeekWalkEnum.LastShallowLayer = 10
WeekWalkEnum.NewDeepLayerMaxNum = 7
WeekWalkEnum.ShallowLayerMaxNum = 10
WeekWalkEnum.HardDeepLayerId = 17

return WeekWalkEnum
