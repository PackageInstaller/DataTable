-- chunkname: @modules/logic/fight/system/work/FightWorkSendEvent.lua

module("modules.logic.fight.system.work.FightWorkSendEvent", package.seeall)

local FightWorkSendEvent = class("FightWorkSendEvent", FightWorkItem)

function FightWorkSendEvent:onLogicEnter(eventName, ...)
	self._eventName = eventName
	self._param = {
		...
	}
	self._paramCount = select("#", ...)
end

function FightWorkSendEvent:onStart()
	self:com_sendFightEvent(self._eventName, unpack(self._param, 1, self._paramCount))
	self:onDone(true)
end

return FightWorkSendEvent
