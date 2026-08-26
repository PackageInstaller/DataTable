-- chunkname: @modules/logic/versionactivity3_2/beilier/define/BeiLiErEnum.lua

module("modules.logic.versionactivity3_2.beilier.define.BeiLiErEnum", package.seeall)

local BeiLiErEnum = _M

BeiLiErEnum.Rotation = {
	90,
	180,
	270,
	360
}
BeiLiErEnum.PuzzleType = {
	OnCrystal = 1,
	OutCrystal = 2
}
BeiLiErEnum.StateType = {
	Correct = 2,
	Normal = 1
}
BeiLiErEnum.IconUrl = {
	[1003] = "puzzle_03/",
	[1001] = "puzzle_01/",
	[1002] = "puzzle_02/",
	[1004] = "puzzle_04/"
}
BeiLiErEnum.LevelType = {
	Game = 2,
	Story = 1
}
BeiLiErEnum.BeForePlayGame = 1000
BeiLiErEnum.AfterPlayGame = 1001
BeiLiErEnum.PlaceRange = 1323101
BeiLiErEnum.TipRange = 1323102
BeiLiErEnum.SpGuideStep2Count = 10
BeiLiErEnum.SpEpisodeType = 1
BeiLiErEnum.HardGameId = 1323109
BeiLiErEnum.GameId2TipCount = {
	[1003] = 10,
	[1001] = 3,
	[1002] = 5,
	[1004] = 15
}

return BeiLiErEnum
