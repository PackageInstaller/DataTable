-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameEnum.lua

module("logic.extensions.orimatgame.model.OriMatGameEnum", package.seeall)

local OriMatGameEnum = {}

OriMatGameEnum.UnitType = {
	Weapon = "weapon",
	Obstacle = "obstacle",
	Monster = "monster",
	Bullet = "bullet"
}
OriMatGameEnum.GridState = {
	ExistUnit = "exist_unit",
	Wall = "wall",
	RoadFirst = "road_first",
	RoadMiddle = "road_middle",
	RoadEnd = "road_end",
	Empty = "empty"
}
OriMatGameEnum.MapCellType = {
	Wall = 5,
	Obstacle = 4,
	RoadFirst = 1,
	RoadMiddle = 2,
	RoadEnd = 3,
	Empty = 0
}
OriMatGameEnum.TaskType = {
	BuildNotLessThan = 2,
	BuildNotGreaterThan = 3,
	KillNotLessThan = 1
}
OriMatGameEnum.StatusType = {
	Burning = "burning",
	Frozen = "frozen",
	SlowDown = "slow_down"
}
OriMatGameEnum.ArrowDirection = {
	Oblique = "oblique",
	Back = "back"
}
OriMatGameEnum.WeaponAttackMode = {
	FixedDir = 2,
	FaceTarget = 1
}
OriMatGameEnum.BuffChangeMode = {
	IncreaseRadius = "increase_radius",
	BulletSizeIncreases = "bullet_size_increases",
	BulletBounce = "bullet_bounce",
	Penetrate = "penetrate"
}
OriMatGameEnum.UnitAttrName = {
	AtkRate = "atkRate",
	AddExplosiveRate = "addExplosiveRate",
	AtkMultiplier = "atkMultiplier",
	BurningTimeMultiplier = "burningTimeMultiplier",
	FrozenTimeMultiplier = "frozenTimeMultiplier",
	SlowDownTimeMultiplier = "slowDownTimeMultiplier",
	DirX = "dirX",
	SkillTriggerCount = "skillTriggerCount",
	CDRate = "cdRate",
	Attack = "atk",
	CD = "cd",
	DirY = "dirY",
	AddBounceCount = "addBounceCount",
	MoveRate = "moveRate"
}
OriMatGameEnum.MapCellWidth = 100

return OriMatGameEnum
