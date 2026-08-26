-- chunkname: @modules/logic/versionactivity2_4/act181/define/Activity181Enum.lua

module("modules.logic.versionactivity2_4.act181.define.Activity181Enum", package.seeall)

local Activity181Enum = _M

Activity181Enum.BonusState = {
	Unlock = 0,
	HaveGet = 1
}
Activity181Enum.SPBonusState = {
	Locked = 0,
	Unlock = 1,
	HaveGet = 2
}
Activity181Enum.SPBonusUnlockType = {
	Time = 1,
	Count = 2,
	HaveGet = 3
}

return Activity181Enum
