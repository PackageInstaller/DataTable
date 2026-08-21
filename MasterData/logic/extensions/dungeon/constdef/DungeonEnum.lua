-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/constdef/DungeonEnum.lua

module("logic.extensions.dungeon.constdef.DungeonEnum", package.seeall)

local DungeonEnum = {}

DungeonEnum.EntranceLockReason = {
	Level = 3,
	Time = 1,
	DungeonProgress = 2
}
DungeonEnum.WeekDay = {
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"日"
}
DungeonEnum.Difficulty = {
	Nightmare = 5,
	Hell = 6,
	ExHard = 4,
	Hard = 3,
	Normal = 2,
	Abyss = 7,
	Easy = 1
}
DungeonEnum.DifficultyName = {
	[DungeonEnum.Difficulty.Easy] = "简单",
	[DungeonEnum.Difficulty.Normal] = "普通",
	[DungeonEnum.Difficulty.Hard] = "困难",
	[DungeonEnum.Difficulty.ExHard] = "极难",
	[DungeonEnum.Difficulty.Nightmare] = "噩梦",
	[DungeonEnum.Difficulty.Hell] = "地狱",
	[DungeonEnum.Difficulty.Abyss] = "深渊"
}
DungeonEnum.MainLineDiffName = {
	[DungeonEnum.Difficulty.Easy] = "稳定",
	[DungeonEnum.Difficulty.Normal] = "异常"
}
DungeonEnum.ReturnJumpType = {
	CharacterSystem = 1
}
DungeonEnum.MainLinePartImg = {
	"fbzx_text_parta_02",
	"fbzx_text_partb_02"
}

return DungeonEnum
