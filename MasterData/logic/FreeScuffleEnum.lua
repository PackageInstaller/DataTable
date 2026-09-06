-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleEnum.lua

module("logic.extensions.freescuffle.view.data.FreeScuffleEnum", package.seeall)

local FreeScuffleEnum = {}

FreeScuffleEnum.BookTabs_Pet = "BookTabs_Pet"
FreeScuffleEnum.BookTabs_Skill = "BookTabs_Skill"
FreeScuffleEnum.BookPages_WorkPet = "BookPages_WorkPet"
FreeScuffleEnum.BookPages_BattlePet = "BookPages_BattlePet"
FreeScuffleEnum.BookPages_NormalSkill = "BookPages_NormalSkill"
FreeScuffleEnum.BookPages_UltSkill = "BookPages_UltSkill"
FreeScuffleEnum.BookPages_HeroSkill = "BookPages_HeroSkill"
FreeScuffleEnum.SkillTypes_Normal = "普攻"
FreeScuffleEnum.SkillTypes_Ult = "超杀"
FreeScuffleEnum.SkillTypes_Hero = "英雄技"
FreeScuffleEnum.SkillTypes = {
	FreeScuffleEnum.SkillTypes_Normal,
	FreeScuffleEnum.SkillTypes_Ult,
	FreeScuffleEnum.SkillTypes_Hero
}
FreeScuffleEnum.SkillTypeInBookPages = {
	[FreeScuffleEnum.BookPages_NormalSkill] = FreeScuffleEnum.SkillTypes_Normal,
	[FreeScuffleEnum.BookPages_UltSkill] = FreeScuffleEnum.SkillTypes_Ult,
	[FreeScuffleEnum.BookPages_HeroSkill] = FreeScuffleEnum.SkillTypes_Hero
}
FreeScuffleEnum.SkillIndexs = {
	[FreeScuffleEnum.SkillTypes_Normal] = 1,
	[FreeScuffleEnum.SkillTypes_Ult] = 2,
	[FreeScuffleEnum.SkillTypes_Hero] = 3
}
FreeScuffleEnum.BookTabNames = {
	[FreeScuffleEnum.BookTabs_Pet] = "精灵图鉴",
	[FreeScuffleEnum.BookTabs_Skill] = "技能图鉴"
}
FreeScuffleEnum.BookTabs = {
	FreeScuffleEnum.BookTabs_Pet,
	FreeScuffleEnum.BookTabs_Skill
}
FreeScuffleEnum.BookPageNames = {
	[FreeScuffleEnum.BookPages_WorkPet] = "营业精灵",
	[FreeScuffleEnum.BookPages_BattlePet] = "作战精灵",
	[FreeScuffleEnum.BookPages_NormalSkill] = "普攻",
	[FreeScuffleEnum.BookPages_UltSkill] = "超杀",
	[FreeScuffleEnum.BookPages_HeroSkill] = "英雄技"
}
FreeScuffleEnum.BookPagesInTabs = {
	[FreeScuffleEnum.BookTabs_Pet] = {
		FreeScuffleEnum.BookPages_WorkPet,
		FreeScuffleEnum.BookPages_BattlePet
	},
	[FreeScuffleEnum.BookTabs_Skill] = {
		FreeScuffleEnum.BookPages_NormalSkill,
		FreeScuffleEnum.BookPages_UltSkill,
		FreeScuffleEnum.BookPages_HeroSkill
	}
}
FreeScuffleEnum.PoolTabs_Pet = "PoolTabs_Pet"
FreeScuffleEnum.PoolTabs_Skill = "PoolTabs_Skill"
FreeScuffleEnum.PoolTypes_WorkPet = 1
FreeScuffleEnum.PoolTypes_Skill = 2
FreeScuffleEnum.PoolTypes_BattlePet = 3
FreeScuffleEnum.PoolTabs = {
	FreeScuffleEnum.PoolTabs_Pet,
	FreeScuffleEnum.PoolTabs_Skill
}
FreeScuffleEnum.PoolTabNames = {
	[FreeScuffleEnum.PoolTabs_Pet] = "精灵卡池",
	[FreeScuffleEnum.PoolTabs_Skill] = "技能卡池"
}
FreeScuffleEnum.PoolTypeNames = {
	[FreeScuffleEnum.PoolTypes_WorkPet] = "打工精灵",
	[FreeScuffleEnum.PoolTypes_BattlePet] = "作战精灵",
	[FreeScuffleEnum.PoolTypes_Skill] = "技能"
}
FreeScuffleEnum.PoolTypeInTabs = {
	[FreeScuffleEnum.PoolTabs_Pet] = {
		FreeScuffleEnum.PoolTypes_WorkPet,
		FreeScuffleEnum.PoolTypes_BattlePet
	},
	[FreeScuffleEnum.PoolTabs_Skill] = {
		FreeScuffleEnum.PoolTypes_Skill
	}
}
FreeScuffleEnum.DrawCardTypes_WorkPet = 1
FreeScuffleEnum.DrawCardTypes_Skill = 2
FreeScuffleEnum.DrawCardTypes_BattlePet = 3
FreeScuffleEnum.DrawCardTypes_ExPrize = 4
FreeScuffleEnum.RankId_Pvp = 1
FreeScuffleEnum.RankId_Coin = 2
FreeScuffleEnum.FmtType_Pk = 1
FreeScuffleEnum.FmtType_Defense = 2
FreeScuffleEnum.TaskGroup_Normal = "normal"
FreeScuffleEnum.TaskGroup_Book = "book"
FreeScuffleEnum.TaskGroup_Day = "day"
FreeScuffleEnum.Units_Coin = {
	{
		1000000000000,
		"T"
	},
	{
		1000000000,
		"B"
	},
	{
		10000000,
		"E"
	},
	{
		1000000,
		"M"
	},
	{
		1000,
		"K"
	}
}

return FreeScuffleEnum
