-- chunkname: @modules/logic/matchgame/fight/defines/MatchGameFightEnum.lua

module("modules.logic.matchgame.fight.defines.MatchGameFightEnum", package.seeall)

local MatchGameFightEnum = _M

MatchGameFightEnum.activityId = 14012
MatchGameFightEnum.planeSizeNum = 7
MatchGameFightEnum.planeItemWidth = 100
MatchGameFightEnum.planeItemHeight = 100
MatchGameFightEnum.planeItemSpace = 14
MatchGameFightEnum.BeadTypeCount = 6
MatchGameFightEnum.MinMatchCount = 3
MatchGameFightEnum.MaxSkillIndex = 4
MatchGameFightEnum.MinEnergyFillAmount = 0.44
MatchGameFightEnum.MaxEnergyFillAmount = 0.87
MatchGameFightEnum.DragAdsorbPower = 4
MatchGameFightEnum.HeroHeavyDamage = 1000
MatchGameFightEnum.EnemyHeavyDamage = 500
MatchGameFightEnum.RoundTimeEndTipTime = 0.3
MatchGameFightEnum.ForceHideClickMaskTime = 12
MatchGameFightEnum.ElementMoveTime = 0.02
MatchGameFightEnum.HurtTxtTime = 0.6
MatchGameFightEnum.DebuffHurtTime = 0.6
MatchGameFightEnum.HeroAttackToEnemyAttackTime = 0.2
MatchGameFightEnum.WaitToNextRoundTime = 0.5
MatchGameFightEnum.MatchMoveFillDoneTime = 0.05
MatchGameFightEnum.MatchTime = 0.1
MatchGameFightEnum.ClickToCreateTime = 0.1
MatchGameFightEnum.MatchSelectItemToCreateTime = 0.1
MatchGameFightEnum.FeverBarChangeTime = 0.1
MatchGameFightEnum.PlayNextBombRoundTime = 0.25
MatchGameFightEnum.GameTimeCountInterval = 0.1
MatchGameFightEnum.NotMatchConvertTime = 0.2
MatchGameFightEnum.HideChainNumUITime = 0.167
MatchGameFightEnum.DoMultiHeroChainAttackTime = 0.34
MatchGameFightEnum.ShowDamageRateTime = 1.2
MatchGameFightEnum.HideDamageRateTime = 0.2
MatchGameFightEnum.ShowGradeTime = 1.167
MatchGameFightEnum.HideGradeTime = 0.167
MatchGameFightEnum.WaitHeroAttackTime = 0.3
MatchGameFightEnum.EachHeroAttackTime = 0.5
MatchGameFightEnum.HpBarChangeTime = 0.1
MatchGameFightEnum.SkillDescShowTime = 1.3
MatchGameFightEnum.DropSkillDescShowTime = 2
MatchGameFightEnum.DelayExcuteTalentSkill = 2
MatchGameFightEnum.ShowNextRoundTimeChangeTipTime = 0.5
MatchGameFightEnum.SkillFinishCheckNotMatchtTime = 0.3
MatchGameFightEnum.CloseFeverAnimTime = 1
MatchGameFightEnum.ElementItemEffectRecycleTime = 1.5
MatchGameFightEnum.ElementItemRangeEffectRecycleTime = 2
MatchGameFightEnum.RoleEffectTime = 1.5
MatchGameFightEnum.RoundTimeBarToFullTime = 0.6
MatchGameFightEnum.CloseRoundTimeChangeTipTime = 1.6
MatchGameFightEnum.CloseSkillDescTime = 0.33
MatchGameFightEnum.RefreshNextWaveTime = 1.5
MatchGameFightEnum.HeroAttackTime = 0.5
MatchGameFightEnum.RoleMeshMaterial = {
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_yellow.mat",
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_blue.mat",
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_green.mat",
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_red.mat",
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_purple.mat",
	"ui/materials/dynamic/outlinesprite_lw_ui_doubleline_orange.mat"
}
MatchGameFightEnum.ScoreRate = {
	MaxChain = 3000,
	SkillUse = 500,
	WeakAttack = 2500,
	Cure = 3
}
MatchGameFightEnum.TestHeroInfoIds = {
	1001,
	1002,
	1008,
	1015
}
MatchGameFightEnum.TestLevelId = 117403101
MatchGameFightEnum.TestEpisodeId = 14010101
MatchGameFightEnum.TestHeroLevel = 1
MatchGameFightEnum.CareerColor = {
	"#955a00",
	"#104c8a",
	"#003603",
	"#a92728",
	"#854e91",
	"#c8870a"
}
MatchGameFightEnum.MemberInfoTag = {
	Enemy = 2,
	Hero = 1
}
MatchGameFightEnum.ConstId = {
	CureElementCureRate = 6,
	HeroGroupUnlockCondition = 4,
	PlaneWidthNum = 1,
	PlaneHeightNum = 2,
	ChainRate = 5,
	SnapShotSize = 3
}
MatchGameFightEnum.ElementItemType = {
	Cure = 3,
	Bead = 1,
	Box = 4,
	Bomb = 2,
	Empty = 0
}
MatchGameFightEnum.BeadType = {
	Career5 = 5,
	Career3 = 3,
	Career6 = 6,
	Career2 = 2,
	Career1 = 1,
	Career4 = 4
}
MatchGameFightEnum.ElementStateType = {
	Poison = 2,
	Lock = 3,
	Normal = 1
}
MatchGameFightEnum.ItemRoot = {
	[MatchGameFightEnum.ElementItemType.Bead] = "go_bead",
	[MatchGameFightEnum.ElementItemType.Bomb] = "go_bomb",
	[MatchGameFightEnum.ElementItemType.Cure] = "go_cure",
	[MatchGameFightEnum.ElementItemType.Box] = "go_box"
}
MatchGameFightEnum.EightRangeOffsetList = {
	{
		-1,
		1
	},
	{
		0,
		1
	},
	{
		1,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	}
}
MatchGameFightEnum.FourRangeOffsetList = {
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		0,
		-1
	}
}
MatchGameFightEnum.FightTargetType = {
	MatchElementNum = 3,
	RoundNum = 2,
	KillAll = 1
}
MatchGameFightEnum.FightResult = {
	Succ = 1,
	Fail = 2,
	None = 0
}
MatchGameFightEnum.TargetGoalTypeNode = {
	[MatchGameFightEnum.FightTargetType.KillAll] = "go_killAll",
	[MatchGameFightEnum.FightTargetType.RoundNum] = "go_roundNum",
	[MatchGameFightEnum.FightTargetType.MatchElementNum] = "go_match"
}
MatchGameFightEnum.SkillUserType = {
	Enemy = 2,
	Hero = 1
}
MatchGameFightEnum.SkillConditionType = {
	OnBattleStart = 4,
	OnTurnEnd = 6,
	OnFeverEnter = 3,
	OnSkillCast = 1,
	OnMatchCountMoreThan = 2,
	OnTurnStart = 5,
	None = 0
}
MatchGameFightEnum.SkillRangeType = {
	Bomb = 2,
	Skill = 1
}
MatchGameFightEnum.SkillBeadType = {
	Buff = 2,
	Bead = 1
}
MatchGameFightEnum.SkillActiveType = {
	Passive = 1,
	Active = 0,
	None = -1
}
MatchGameFightEnum.BuffType = {
	AttrUp = 8,
	HeroSick = 3,
	MatchTimeChange = 5,
	Poison = 1,
	BeadRateChange = 4,
	FeverTimeChange = 6,
	AttrDown = 9,
	Seal = 2,
	FeverCostChange = 7,
	None = 0
}
MatchGameFightEnum.BuffEffectType = {
	FeverTime = "FeverTime",
	AttackRate = "AttackRate",
	FeverCost = "FeverCost",
	Giddy = "Giddy",
	Seal = "Seal",
	GemProbability = "GemProbability",
	MatchTime = "MatchTime",
	Poison = "Poison"
}
MatchGameFightEnum.EnemyNextRoundBuffEffectIdMap = {
	[107] = true,
	[111] = true,
	[109] = true
}
MatchGameFightEnum.BuffDurationType = {
	Round = 1,
	Second = 3,
	Match = 2,
	Forever = 0
}
MatchGameFightEnum.SkillTargetType = {
	Range = 101,
	BuffType = 105,
	CharacterAll = 202,
	RoundTime = 111,
	Neighbor4 = 107,
	FeverCost = 112,
	CharacterSingle = 201,
	DropRate = 110,
	Board = 100,
	RandomColor = 103,
	GemType = 102,
	MonsterSingle = 301,
	Neighbor8 = 108,
	RandomCount = 106,
	LastClear = 109
}
MatchGameFightEnum.SkillEffectType = {
	Generate = 1009,
	BombSkillRange = 1010,
	RemoveBuffType = 1006,
	Remove = 1011,
	Heal = 1003,
	AddBuff = 1004,
	Attr = 1008,
	Convert = 1002,
	Attack = 1007,
	RemoveBuff = 1005,
	Destory = 1001
}
MatchGameFightEnum.SkillAttrType = {
	Heal = 4,
	Attack = 1,
	Hp = 3,
	Def = 2
}
MatchGameFightEnum.SkillToastType = {
	SkillDesc = 2,
	FeverDesc = 3,
	DropRate = 1
}
MatchGameFightEnum.RoleEffectType = {
	Clean = "Clean",
	NormalDamage = "NormalDamage",
	HeavyDamage = "HeavyDamage",
	Heal = "Heal",
	Lock = "Lock",
	Poison = "Poison"
}
MatchGameFightEnum.ItemMatchEffect = {
	Heal = "heal",
	Bomb = "bomb",
	Cleanse = "cleanse",
	SkillLineH = "skillLineH",
	MatchLine = "matchLine",
	MatchAoe = "matchAoe",
	SkillAoe = "skillAoe",
	MatchNormal = "matchNormal",
	SkillLineV = "skillLineV"
}
MatchGameFightEnum.SkillEffectRangeType = {
	LineV = 3,
	LineH = 2,
	Circle = 1
}
MatchGameFightEnum.GuideDataList = {
	{
		episodeId = 14010101,
		guideId = 40022,
		guideList = {
			{
				id = 1,
				posIndexList = {
					{
						2,
						3
					},
					{
						2,
						4
					},
					{
						2,
						5
					}
				}
			},
			{
				id = 2,
				posIndexList = {
					{
						6,
						2
					},
					{
						5,
						3
					},
					{
						4,
						4
					}
				}
			},
			{
				id = 3,
				posIndexList = {
					{
						1,
						6
					},
					{
						2,
						6
					},
					{
						3,
						6
					}
				}
			},
			{
				id = 4,
				posIndexList = {
					{
						3,
						3
					},
					{
						3,
						4
					},
					{
						3,
						5
					},
					{
						3,
						6
					},
					{
						3,
						7
					}
				}
			}
		}
	},
	{
		episodeId = 14010102,
		guideId = 40023,
		guideList = {
			{
				id = 1,
				posIndexList = {
					{
						2,
						1
					},
					{
						2,
						2
					},
					{
						2,
						3
					}
				}
			},
			{
				id = 2,
				posIndexList = {
					{
						3,
						3
					},
					{
						4,
						3
					},
					{
						5,
						3
					}
				}
			},
			{
				id = 3,
				posIndexList = {
					{
						3,
						3
					},
					{
						4,
						3
					},
					{
						5,
						3
					}
				}
			}
		}
	},
	{
		episodeId = 14010106,
		guideId = 40024,
		guideList = {
			{
				id = 1,
				posIndexList = {
					{
						1,
						7
					},
					{
						2,
						7
					},
					{
						3,
						7
					},
					{
						4,
						7
					},
					{
						5,
						7
					},
					{
						6,
						7
					},
					{
						7,
						7
					}
				}
			}
		}
	}
}

return MatchGameFightEnum
