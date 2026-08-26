-- chunkname: @modules/logic/enemyinfo/define/EnemyInfoEnum.lua

module("modules.logic.enemyinfo.define.EnemyInfoEnum", package.seeall)

local EnemyInfoEnum = _M

EnemyInfoEnum.TabEnum = {
	Act191 = 7,
	WeekWalk_2 = 6,
	Rouge = 5,
	Season123 = 3,
	Survival = 8,
	TowerDeep = 9,
	Sodache = 11,
	WeekWalk = 2,
	BossRush = 4,
	TowerCompose = 10,
	Normal = 1
}
EnemyInfoEnum.TabWidth = 252
EnemyInfoEnum.LeftTabRatio = 0.45
EnemyInfoEnum.RightTabRatio = 0.55
EnemyInfoEnum.LineHeight = 2
EnemyInfoEnum.RuleTopMargin = 70
EnemyInfoEnum.RuleItemHeight = 180
EnemyInfoEnum.RuleItemWeight = 140
EnemyInfoEnum.SkillDescLeftMargin = 100
EnemyInfoEnum.EnemyGroupLeftMargin = 94
EnemyInfoEnum.ScrollEnemyMargin = {
	Left = 80,
	Up = 0,
	Bottom = 300,
	Right = 100
}
EnemyInfoEnum.EnemyInfoMargin = {
	Left = 100,
	Right = 50
}
EnemyInfoEnum.WithTabOffset = {
	LeftRatio = -0.03,
	EnemyInfoLeftMargin = -60,
	ScrollEnemyLeftMargin = -10,
	RightRatio = 0.03,
	ScrollEnemyUpMargin = 30
}
EnemyInfoEnum.Tip = {
	BuffTip = 2,
	RuleTip = 1
}
EnemyInfoEnum.TagColor = {
	"#6680bd",
	"#d05b4c",
	"#c7b376"
}
EnemyInfoEnum.StageColor = {
	Normal = Color(0.596078431372549, 0.596078431372549, 0.596078431372549, 1),
	Select = Color(1, 1, 1, 1)
}
EnemyInfoEnum.TipOffsetX = 20
EnemyInfoEnum.BuffTipOffset = {
	x = 40,
	y = 30
}

return EnemyInfoEnum
