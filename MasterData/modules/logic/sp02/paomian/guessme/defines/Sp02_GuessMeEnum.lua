-- chunkname: @modules/logic/sp02/paomian/guessme/defines/Sp02_GuessMeEnum.lua

module("modules.logic.sp02.paomian.guessme.defines.Sp02_GuessMeEnum", package.seeall)

local Sp02_GuessMeEnum = _M

Sp02_GuessMeEnum.TaskStatus = {
	Finish = 3,
	CanGet = 2,
	UnLock = 1,
	Lock = 0
}

return Sp02_GuessMeEnum
