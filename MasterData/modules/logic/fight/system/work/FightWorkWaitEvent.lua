-- chunkname: @modules/logic/fight/system/work/FightWorkWaitEvent.lua

module("modules.logic.fight.system.work.FightWorkWaitEvent", package.seeall)

local FightWorkWaitEvent = class("FightWorkWaitEvent", FightWorkItem)

function FightWorkWaitEvent:onConstructor(eventId)
	self.eventId = eventId
end

function FightWorkWaitEvent:onStart()
	self:com_registFightEvent(self.eventId, self.onEvent)
	self:cancelFightWorkSafeTimer()
end

function FightWorkWaitEvent:onEvent()
	self:onDone(true)
end

return FightWorkWaitEvent
