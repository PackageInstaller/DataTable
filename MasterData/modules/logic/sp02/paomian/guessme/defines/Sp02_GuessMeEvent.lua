-- chunkname: @modules/logic/sp02/paomian/guessme/defines/Sp02_GuessMeEvent.lua

module("modules.logic.sp02.paomian.guessme.defines.Sp02_GuessMeEvent", package.seeall)

local Sp02_GuessMeEvent = _M

Sp02_GuessMeEvent.OnSelectGuessMeDay = GameUtil.getEventId()
Sp02_GuessMeEvent.OnUpdateGuessMe = GameUtil.getEventId()
Sp02_GuessMeEvent.OnSelectGuessMeOption = GameUtil.getEventId()

return Sp02_GuessMeEvent
