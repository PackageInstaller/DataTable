-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotEnum.lua

module("logic.extensions.defendcarrot.model.DefendCarrotEnum", package.seeall)

local DefendCarrotEnum = {}

DefendCarrotEnum.UnitType = {
	Weapon = "weapon",
	Obstacle = "obstacle",
	Monster = "monster",
	Bullet = "bullet"
}
DefendCarrotEnum.GridState = {
	ExistUnit = "exist_unit",
	Wall = "wall",
	RoadFirst = "road_first",
	RoadMiddle = "road_middle",
	RoadEnd = "road_end",
	Empty = "empty"
}
DefendCarrotEnum.MapCellType = {
	Wall = 5,
	Obstacle = 4,
	RoadFirst = 1,
	RoadMiddle = 2,
	RoadEnd = 3,
	Empty = 0
}
DefendCarrotEnum.LevelMode_Normal = 1
DefendCarrotEnum.LevelMode_Material = 2
DefendCarrotEnum.TaskType = {
	BuildNotLessThan = 2,
	BuildNotGreaterThan = 3,
	KillNotLessThan = 1
}
DefendCarrotEnum.StatusType = {
	Burning = "burning",
	Frozen = "frozen",
	SlowDown = "slow_down"
}
DefendCarrotEnum.ArrowDirection = {
	Oblique = "oblique",
	Back = "back"
}
DefendCarrotEnum.WeaponAttackMode = {
	FixedDir = 2,
	FaceTarget = 1
}
DefendCarrotEnum.BuffChangeMode = {
	IncreaseRadius = "increase_radius",
	BulletSizeIncreases = "bullet_size_increases",
	BulletBounce = "bullet_bounce",
	Penetrate = "penetrate"
}
DefendCarrotEnum.UnitAttrName = {
	FrozenTimeMultiplier = "frozenTimeMultiplier",
	AddExplosiveRate = "addExplosiveRate",
	AtkMultiplier = "atkMultiplier",
	BurningTimeMultiplier = "burningTimeMultiplier",
	SlowDownTimeMultiplier = "slowDownTimeMultiplier",
	DirX = "dirX",
	SkillTriggerCount = "skillTriggerCount",
	Attack = "atk",
	CD = "cd",
	DirY = "dirY",
	AddBounceCount = "addBounceCount",
	MoveRate = "moveRate"
}
DefendCarrotEnum.MapCellWidth = 100

return DefendCarrotEnum
