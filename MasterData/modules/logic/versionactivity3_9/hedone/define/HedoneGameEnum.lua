-- chunkname: @modules/logic/versionactivity3_9/hedone/define/HedoneGameEnum.lua

module("modules.logic.versionactivity3_9.hedone.define.HedoneGameEnum", package.seeall)

local HedoneGameEnum = _M

HedoneGameEnum.Const = {
	PermillageBase = 1000,
	PercentBase = 100,
	EffectResPath = "effects/prefabs/v3a9_hedone/%s.prefab",
	NewSkillPrefsVal = 0,
	PlayerSpineRes = "roles/v3a9_315601_hdn/315601_hdn_ui.prefab",
	StressTime = 10,
	EffectBaseFactor = 1,
	NewSkillPrefsKey = "HedoneGameEnum_NewSkill_",
	OldSkillPrefsVal = 1,
	SkillCfgMaxKeyIndex = 3,
	PlayerUid = 0,
	BaseScaleFactor = 1,
	DisablePos = 10000,
	EntityDefaultName = "unUsing",
	PlayAttackSkillType = 1,
	SkillCDEPS = 0.001
}
HedoneGameEnum.FindTargetType = {
	Random = 4,
	HighestHp = 1,
	Player = -1,
	MostSurround = 3,
	Farthest = 2,
	Nearest = 0
}
HedoneGameEnum.WaveRandomType = {
	GroupType = 1,
	GroupId = 2
}
HedoneGameEnum.StopSource = {
	SkillPanel = 1,
	GMPanel = 3,
	ExitDialog = 2
}
HedoneGameEnum.EntityAnimName = {
	PlayerAttack = "v3a9_hedone_gameview_player_attack",
	Attack = "attack",
	Born = "open",
	Hit = "hit",
	Die = "die",
	Move = "move"
}
HedoneGameEnum.EntityType = {
	Player = 1,
	Effect = 4,
	Monster = 2,
	Bullet = 3
}
HedoneGameEnum.EntityTypeMOCls = {
	[HedoneGameEnum.EntityType.Player] = HedonePlayerMO,
	[HedoneGameEnum.EntityType.Monster] = HedoneMonsterMO,
	[HedoneGameEnum.EntityType.Bullet] = HedoneBulletMO,
	[HedoneGameEnum.EntityType.Effect] = HedoneEffectMO
}
HedoneGameEnum.EntityTypeEntityCls = {
	[HedoneGameEnum.EntityType.Monster] = HedoneMonsterEntity,
	[HedoneGameEnum.EntityType.Bullet] = HedoneBulletEntity,
	[HedoneGameEnum.EntityType.Effect] = HedoneEffectEntity
}
HedoneGameEnum.MovableEntityTypeDict = {
	[HedoneGameEnum.EntityType.Monster] = true,
	[HedoneGameEnum.EntityType.Bullet] = true
}
HedoneGameEnum.Attribute = {
	HpCap = 3,
	Def = 2,
	SkillCD = 11,
	SkillBulletCount = 12,
	SkillLinkCount = 10,
	ComboDmg = 6,
	ComboRate = 5,
	EffectDuration = 15,
	EffectValue = 13,
	CritDmg = 8,
	Hp = 4,
	Atk = 1,
	EffectRange = 14,
	CritRate = 7,
	GlobalSkillCD = 9,
	MonsterSpeed = 16
}
HedoneGameEnum.BaseAttribute = {
	[HedoneGameEnum.Attribute.Atk] = true,
	[HedoneGameEnum.Attribute.Def] = true,
	[HedoneGameEnum.Attribute.HpCap] = true,
	[HedoneGameEnum.Attribute.Hp] = true
}
HedoneGameEnum.AttributeOwnerType = {
	Effect = 2,
	Skill = 1,
	Unit = 0
}
HedoneGameEnum.SkillCfgKey = {
	TriggerPoint = "triggerPoint",
	Probability = "probability",
	Param = "param"
}
HedoneGameEnum.TriggerPoint = {
	AfterCDSkillCombo = "2",
	AfterHitEffect = "6",
	AfterPlayerHurt = "5",
	AfterAttackEffectCrit = "3",
	CDSkillReady2Cast = "1",
	AfterEffectKillMonster = "4",
	AfterFindCDSkillEffectTarget = "7",
	None = "0"
}
HedoneGameEnum.EffectType = {
	SingleDOT = 2,
	ResetCD = 6,
	GatherMonster = 5,
	AreaAttack = 3,
	AreaDOT = 4,
	AddBuff = 7,
	SingleAttack = 1
}
HedoneGameEnum.EffectTypeCls = {
	[HedoneGameEnum.EffectType.SingleAttack] = HedoneEffectAttack,
	[HedoneGameEnum.EffectType.SingleDOT] = HedoneEffectAttack,
	[HedoneGameEnum.EffectType.AreaAttack] = HedoneEffectAttack,
	[HedoneGameEnum.EffectType.AreaDOT] = HedoneEffectAttack,
	[HedoneGameEnum.EffectType.GatherMonster] = HedoneEffectGatherMonster,
	[HedoneGameEnum.EffectType.ResetCD] = HedoneEffectResetCD,
	[HedoneGameEnum.EffectType.AddBuff] = HedoneEffectAddBuff
}
HedoneGameEnum.EffectLifeRule = {
	Timed = 1,
	CountBased = 2,
	Once = 0
}
HedoneGameEnum.SkillState = {
	Casting = 2,
	Ready = 1,
	Cooldown = 3
}
HedoneGameEnum.BuffLifeRule = {
	CDSkillCast = "2",
	Permanent = "0",
	Timed = "1"
}
HedoneGameEnum.BuffLifeRuleDict = {
	[HedoneGameEnum.BuffLifeRule.Permanent] = true,
	[HedoneGameEnum.BuffLifeRule.Timed] = true,
	[HedoneGameEnum.BuffLifeRule.CDSkillCast] = true
}
HedoneGameEnum.BuffAffectType = {
	changeAttrFixed = 1,
	changeAttrPermille = 2
}
HedoneGameEnum.BuffAffectType2ModifierCls = {
	[HedoneGameEnum.BuffAffectType.changeAttrFixed] = HedoneFixedModifier,
	[HedoneGameEnum.BuffAffectType.changeAttrPermille] = HedonePermilleModifier
}

return HedoneGameEnum
