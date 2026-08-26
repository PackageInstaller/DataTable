-- chunkname: @modules/logic/character/defines/CharacterRecommedEnum.lua

module("modules.logic.character.defines.CharacterRecommedEnum", package.seeall)

local CharacterRecommedEnum = _M

CharacterRecommedEnum.TabSubType = {
	DevelopGoals = 2,
	RecommedGroup = 1
}
CharacterRecommedEnum.DevelopGoalsType = {
	RankLevel = 1,
	TalentLevel = 2
}
CharacterRecommedEnum.JumpView = {
	Level = 2,
	Rank = 1,
	Dungeon = 3
}
CharacterRecommedEnum.ResDungeon = {
	[DungeonEnum.ChapterId.ResourceExp] = {
		UnlockFunc = OpenEnum.UnlockFunc.GoldDungeon
	},
	[DungeonEnum.ChapterId.ResourceGold] = {
		UnlockFunc = OpenEnum.UnlockFunc.ExperienceDungeon
	},
	[DungeonEnum.ChapterId.EquipDungeonChapterId] = {
		UnlockFunc = OpenEnum.UnlockFunc.EquipDungeon
	},
	[DungeonEnum.ChapterId.HarvestDungeonChapterId] = {
		UnlockFunc = OpenEnum.UnlockFunc.Buildings
	}
}
CharacterRecommedEnum.RankResDungeon = {
	DungeonEnum.ChapterId.InsightMountain,
	DungeonEnum.ChapterId.InsightStarfall,
	DungeonEnum.ChapterId.InsightSylvanus,
	DungeonEnum.ChapterId.InsightBrutes
}
CharacterRecommedEnum.AnimName = {
	Switch = "switch",
	Close = "close",
	Open = "open"
}
CharacterRecommedEnum.TracedIconPath = "ui/viewres/character/recommed/traceitem.prefab"
CharacterRecommedEnum.TraceHeroPref = "CharacterRecommedEnum_TraceHeroPref_"

return CharacterRecommedEnum
