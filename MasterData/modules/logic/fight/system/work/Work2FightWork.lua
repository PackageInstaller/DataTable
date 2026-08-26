-- chunkname: @modules/logic/fight/system/work/Work2FightWork.lua

module("modules.logic.fight.system.work.Work2FightWork", package.seeall)

local Work2FightWork = class("Work2FightWork", FightWorkItem)

function Work2FightWork:onLogicEnter(class, ...)
	self._class = class
	self._param = {
		...
	}
	self._paramCount = select("#", ...)
end

function Work2FightWork:onStart()
	self._work = self._class.New(unpack(self._param, 1, self._paramCount))

	self._work:registerDoneListener(self.onWorkItemDone, self)
	self:cancelFightWorkSafeTimer()

	return self._work:onStartInternal(self.context)
end

function Work2FightWork:onWorkItemDone()
	return self:onDone(true)
end

function Work2FightWork:clearWork()
	if self._work then
		self._work:unregisterDoneListener(self.onWorkItemDone, self)
		self._work:onDestroy()

		self._work = nil
	end
end

return Work2FightWork
