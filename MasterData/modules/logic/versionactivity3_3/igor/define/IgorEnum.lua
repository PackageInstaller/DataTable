-- chunkname: @modules/logic/versionactivity3_3/igor/define/IgorEnum.lua

module("modules.logic.versionactivity3_3.igor.define.IgorEnum", package.seeall)

local IgorEnum = _M

IgorEnum.SoldierType = {
	Artillery = 3,
	Infantry = 1,
	Chariot = 4,
	Base = 0,
	Cavalry = 2
}
IgorEnum.CampType = {
	Ourside = 1,
	Enemy = 2
}
IgorEnum.ConstId = {
	SkillCost1 = 3,
	TransferTips = 10,
	SkillCD2 = 5,
	LevelUpTips = 11,
	SkillCost3 = 9,
	DefenseTips = 13,
	CostSpeedUpTime = 14,
	SkillCD1 = 2,
	SkillCost2 = 6,
	CostRecoverySpeed = 1,
	SkillCD3 = 8,
	SkillValue1 = 4,
	AttackTips = 12,
	SkillValue2 = 7
}
IgorEnum.RefreshList = {
	IgorEnum.CampType.Ourside,
	IgorEnum.CampType.Enemy
}
IgorEnum.SkillType = {
	Transfer = 3,
	Attack = 1,
	Defense = 2,
	Levup = 4
}
IgorEnum.EntityState = {
	Attack = 5,
	Idle = 1,
	In = 2,
	WaitAttack = 6,
	Die = 4,
	Move = 3
}
IgorEnum.EntityAnimName = {
	Damage = "damage",
	Attack = "attack",
	Idle = "idle",
	In = "in",
	Die = "die",
	Move = "move"
}
IgorEnum.StatOperationType = {
	Finish = "finish",
	Reset = "reset",
	Fail = "fail",
	Exit = "exit"
}

return IgorEnum
