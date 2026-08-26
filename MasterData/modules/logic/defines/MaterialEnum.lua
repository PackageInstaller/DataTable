-- chunkname: @modules/logic/defines/MaterialEnum.lua

module("modules.logic.defines.MaterialEnum", package.seeall)

local MaterialEnum = _M

MaterialEnum.MaterialType = {
	Bp = 25,
	SpecialExpiredItem = 29,
	HeroSkin = 5,
	SpecialBlock = 14,
	Exp = 3,
	Faith = 6,
	EquipCard = 16,
	NewInsight = 24,
	ActBp = 33,
	Building = 11,
	Item = 1,
	Formula = 12,
	Season123EquipCard = 19,
	Hero = 4,
	BlockPackage = 13,
	Act186Like = 26,
	Critter = 27,
	Equip = 9,
	PowerPotion = 10,
	PlayerClothExp = 8,
	Explore = 15,
	PlayerCloth = 7,
	Antique = 18,
	Currency = 2,
	RoomTheme = 1001,
	UnlockVoucher = 28,
	TalentItem = 31,
	V1a5AiZiLa = 1002,
	None = 0
}
MaterialEnum.JumpProbability = {
	Small = 3,
	Little = 5,
	Large = 2,
	Must = 1,
	VerySmall = 4,
	Normal = 0
}
MaterialEnum.GetApproach = {
	Birthday = 153,
	RoomProductLine = 34,
	v2a2Act169SummonNewPick = 119,
	Act1_6SkillReset = 85,
	MonthCard = 42,
	RoomProductChange = 38,
	Activity = 25,
	v1a8Act157ComponentReward = 96,
	Act1_6SkillLvDown = 84,
	SeasonCard = 129,
	Charge = 31,
	SkinCoupon = 139,
	RoomInteraction = 47,
	RoomGainFaith = 46,
	AutoChessPveReward = 127,
	Activity197View = 138,
	DungeonRewardPoint = 28,
	Task = 8,
	TaskAct = 13,
	SmallMonthCard = 125,
	Explore = 45,
	BattlePass = 49,
	AutoChessRankReward = 134,
	AtomicDungeon = 168,
	CommandStationPaperReward = 169,
	AstrologyStarReward = 62,
	PartyClothSummon = 158,
	SignIn = 20,
	ActBp = 173,
	LifeCircleSign = 133,
	NoviceStageReward = 54
}
MaterialEnum.TaskGetApproachLimit = {
	Max = 19999,
	Min = 10000
}
MaterialEnum.SubTypePackages = {
	[53] = true,
	[50] = true,
	[52] = true
}
MaterialEnum.SubTypeInPack = {
	[ItemEnum.SubType.RoomBlockGiftNew] = true,
	[ItemEnum.SubType.RoomBlockGift] = true,
	[ItemEnum.SubType.SkinSelelctGift] = true,
	[ItemEnum.SubType.EquipSelectGift] = true,
	[ItemEnum.SubType.HeroExpBox] = true,
	[ItemEnum.SubType.NewDestinyStoneUp] = true,
	[ItemEnum.SubType.HeroExpBox] = true,
	[ItemEnum.SubType.RandomNewItemBox] = true
}
MaterialEnum.JumpProbabilityDisplay = {
	[MaterialEnum.JumpProbability.Normal] = "material_jump_probability_normal",
	[MaterialEnum.JumpProbability.Must] = "material_jump_probability_must",
	[MaterialEnum.JumpProbability.Large] = "material_jump_probability_large",
	[MaterialEnum.JumpProbability.Small] = "material_jump_probability_small",
	[MaterialEnum.JumpProbability.VerySmall] = "material_jump_probability_verysmall",
	[MaterialEnum.JumpProbability.Little] = "material_jump_probability_little"
}
MaterialEnum.ItemSubType16 = 16
MaterialEnum.ItemRareN = 2
MaterialEnum.ItemRareR = 3
MaterialEnum.ItemRareSR = 4
MaterialEnum.ItemRareSSR = 5
MaterialEnum.PowerId = {
	BigPower_Expire = 11,
	SmallPower = 20,
	ActPowerId = 30,
	OverflowPowerId = 31,
	SmallPower_Expire = 10,
	BigPower = 21
}
MaterialEnum.PowerType = {
	Big = 2,
	Overflow = 4,
	Act = 3,
	Small = 1
}
MaterialEnum.ItemSubType = {
	MainScene = 24,
	Icon = 17,
	SelfCard = 21
}
MaterialEnum.PowerMakerStatus = {
	Making = 1,
	Pause = 0
}
MaterialEnum.PowerMakerItemId = 140055
MaterialEnum.PowerMakerFixedPauseTime = 43200
MaterialEnum.ActPowerBindActId = 11904

return MaterialEnum
