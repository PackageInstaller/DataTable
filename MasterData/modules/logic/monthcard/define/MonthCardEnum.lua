-- chunkname: @modules/logic/monthcard/define/MonthCardEnum.lua

module("modules.logic.monthcard.define.MonthCardEnum", package.seeall)

local MonthCardEnum = _M

MonthCardEnum.Act240SignState = {
	CanSigned = 1,
	HasGet = 2,
	Unsigned = 0
}

return MonthCardEnum
