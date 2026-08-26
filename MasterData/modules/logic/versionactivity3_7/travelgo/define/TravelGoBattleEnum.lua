-- chunkname: @modules/logic/versionactivity3_7/travelgo/define/TravelGoBattleEnum.lua

module("modules.logic.versionactivity3_7.travelgo.define.TravelGoBattleEnum", package.seeall)

local TravelGoBattleEnum = _M

TravelGoBattleEnum.EntityType = {
	Player = 1,
	Enemy = 2,
	Npc = 3
}
TravelGoBattleEnum.EffectCheckType = {
	ComboEffect = 6,
	CounterEffect = 5,
	AttackEffect = 4,
	RoundStart = 2,
	AfterAttack = 100,
	RoundStartEffect = 11,
	ReleaseUltimate = 9,
	SkillCreate = -1,
	BattleStart = 1,
	TriggerEffect = 10,
	BeforeAttack = 3,
	CritEffect = 7
}
TravelGoBattleEnum.AttrType = {
	CounterAttackRate = 13,
	CritDamage = 15,
	Frozen = 3750,
	ComboDamage = 14,
	FrozenDamage = 3720,
	MaxHp = 1,
	UltimateDamage = 17,
	HpRecoverPerRound = 3760,
	Attack = 3,
	CritRate = 12,
	Defence = 4,
	LightningBoltDamage = 3710,
	AttackDamage = 5,
	CounterAttackDamage = 16,
	ComboRate = 11,
	Rage = 2,
	Hp = 0,
	ComboLimit = 3740,
	SkillDamage = 6,
	ThrowingKnifeDamage = 3730
}

return TravelGoBattleEnum
