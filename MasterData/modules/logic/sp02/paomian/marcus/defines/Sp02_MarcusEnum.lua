-- chunkname: @modules/logic/sp02/paomian/marcus/defines/Sp02_MarcusEnum.lua

module("modules.logic.sp02.paomian.marcus.defines.Sp02_MarcusEnum", package.seeall)

local Sp02_MarcusEnum = _M

Sp02_MarcusEnum.BonusStatus = {
	Finish = 2,
	CanGet = 1,
	Lock = 0
}
Sp02_MarcusEnum.PlayDescSpeed = 30

return Sp02_MarcusEnum
