-- chunkname: @modules/logic/versionactivity2_6/dicehero/defines/DiceHeroEnum.lua

module("modules.logic.versionactivity2_6.dicehero.defines.DiceHeroEnum", package.seeall)

local DiceHeroEnum = _M

DiceHeroEnum.LevelType = {
	Fight = 2,
	Story = 1
}
DiceHeroEnum.GetRewardType = {
	All = 1,
	One = 2,
	None = 0
}
DiceHeroEnum.RewardType = {
	SkillCard = 2,
	Hero = 1,
	Relic = 3
}
DiceHeroEnum.DialogContentType = {
	Narration = 3,
	Talk = 2,
	Title = 1
}
DiceHeroEnum.SkillType = {
	Hero = 2,
	Normal = 1
}
DiceHeroEnum.GameStatu = {
	Win = 1,
	Lose = 2,
	None = 0
}
DiceHeroEnum.SkillEffectType = {
	FixDamageByDicePoint = 108,
	AddBuff = 40,
	FixAddShield = 107,
	Damage3 = 12,
	AddBuffLayer = 41,
	BanSkillCard = 110,
	BuffAddBuff = 109,
	ChangeShield1 = 20,
	LockDice = 105,
	FixDamageRate2 = 111,
	ChangePower1 = 30,
	AddShield = 103,
	DiceMix = 112,
	Damage1 = 10,
	FixDamageAddValue = 106,
	ChangeMaxPower = 32,
	ChangeShield2 = 21,
	FixDamageRate = 104,
	DamageByType = 102,
	ChangeShield3 = 22,
	ChangePower2 = 31,
	Damage2 = 11,
	AddDice = 101
}
DiceHeroEnum.GameProgress = {
	PlaySkill = 1,
	RollDice = 2,
	UseSkill = 3,
	None = 0
}
DiceHeroEnum.DiceStatu = {
	HardLock = 2,
	SoftLock = 1,
	Normal = 0
}
DiceHeroEnum.DiceType = {
	Power = 4,
	Def = 2,
	Atk = 1
}
DiceHeroEnum.BaseDiceSuitDict = {
	[DiceHeroEnum.DiceType.Atk] = true,
	[DiceHeroEnum.DiceType.Def] = true,
	[DiceHeroEnum.DiceType.Power] = true
}
DiceHeroEnum.CardType = {
	Power = 3,
	Def = 2,
	Hero = 4,
	Atk = 1
}
DiceHeroEnum.HeroCardType = {
	PassiveSkill = 2,
	ActiveSkill = 1,
	None = 0
}
DiceHeroEnum.FightActionType = {
	UseSkill = 1,
	Effect = 2
}
DiceHeroEnum.FightEffectType = {
	ChangePower = 5,
	RemoveBuff = 2,
	Damage = 8,
	ChangeMaxPower = 6,
	ChangeHp = 7,
	AddBuff = 1,
	UpdateSkillCard = 10,
	DiceChangeStatus = 9,
	DiceBoxFull = 12,
	UpdateDiceBox = 11,
	UpdateBuff = 3,
	ChangeShield = 4
}
DiceHeroEnum.SkillCardTargetType = {
	RandomEnemy = 4,
	Self = 2,
	AllEnemy = 3,
	SingleEnemy = 1,
	None = 0
}
DiceHeroEnum.CantUseReason = {
	NoUseCount = 2,
	NoDice = 1,
	BanSkill = 3
}
DiceHeroEnum.FightEffectTypeToName = {}

for k, v in pairs(DiceHeroEnum.FightEffectType) do
	DiceHeroEnum.FightEffectTypeToName[v] = k
end

return DiceHeroEnum
