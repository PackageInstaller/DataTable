-- chunkname: @modules/logic/versionactivity3_3/marsha/define/MarshaEnum.lua

module("modules.logic.versionactivity3_3.marsha.define.MarshaEnum", package.seeall)

local MarshaEnum = _M

MarshaEnum.MapSize = Vector2(3840, 2160)
MarshaEnum.WeightRate = 0.001
MarshaEnum.Shape = {
	Rect = 1,
	Circle = 2
}
MarshaEnum.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Left = 2,
	None = 0
}
MarshaEnum.UnitType = {
	SubWeight = 5,
	Dead = 6,
	Player = 1,
	Debuff = 3,
	Speed = 2,
	Exp = 7,
	Inverse = 4
}
MarshaEnum.UnitTypeToName = {}

for name, index in pairs(MarshaEnum.UnitType) do
	MarshaEnum.UnitTypeToName[index] = name
end

MarshaEnum.TriggerType = {
	[MarshaEnum.UnitType.Speed] = {
		1,
		3
	},
	[MarshaEnum.UnitType.Debuff] = {
		1,
		2,
		4,
		5,
		6,
		7
	},
	[MarshaEnum.UnitType.Inverse] = {
		1,
		3
	},
	[MarshaEnum.UnitType.SubWeight] = {
		1,
		3
	},
	[MarshaEnum.UnitType.Dead] = {
		1,
		3
	},
	[MarshaEnum.UnitType.Exp] = {
		1,
		3
	}
}
MarshaEnum.CheckMoveInterval = 2
MarshaEnum.MoveType = {
	ClosePlayer = "closePlayer",
	LeavePlayer = "leavePlayer",
	RanToward = "ranToward"
}
MarshaEnum.TargetType = {
	KillType = "KillType",
	Weight = "Weight"
}
MarshaEnum.SkillType = {
	Passive = 2,
	Active = 1
}
MarshaEnum.Result = {
	Esc = "主动中断（重置）",
	Reset = "重开",
	Fail = "失败",
	Success = "成功"
}
MarshaEnum.FailReason = {
	NoTime = "剩余时间为0",
	Despair = "绝望点数上限",
	NoHp = "血量归0"
}

return MarshaEnum
