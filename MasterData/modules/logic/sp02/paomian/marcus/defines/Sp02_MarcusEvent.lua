-- chunkname: @modules/logic/sp02/paomian/marcus/defines/Sp02_MarcusEvent.lua

module("modules.logic.sp02.paomian.marcus.defines.Sp02_MarcusEvent", package.seeall)

local Sp02_MarcusEvent = _M

Sp02_MarcusEvent.OnSelectMarcusDay = GameUtil.getEventId()
Sp02_MarcusEvent.OnUpdateMarcus = GameUtil.getEventId()

return Sp02_MarcusEvent
