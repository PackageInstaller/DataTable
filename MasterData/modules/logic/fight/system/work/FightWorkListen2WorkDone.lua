-- chunkname: @modules/logic/fight/system/work/FightWorkListen2WorkDone.lua

module("modules.logic.fight.system.work.FightWorkListen2WorkDone", package.seeall)

local FightWorkListen2WorkDone = class("FightWorkListen2WorkDone", FightWorkItem)

function FightWorkListen2WorkDone:onConstructor(work)
	self._work = work
end

function FightWorkListen2WorkDone:onStart()
	if self._work.IS_DISPOSED then
		self:onDone(true)

		return
	end

	if self._work.WORK_IS_FINISHED then
		self:onDone(true)

		return
	end

	self:cancelFightWorkSafeTimer()

	if self._work.STARTED then
		self._work:registFinishCallback(self.onWorkItemDone, self)

		return
	end

	self._work:registFinishCallback(self.onWorkItemDone, self)

	return self._work:start(self.context)
end

function FightWorkListen2WorkDone:onWorkItemDone()
	return self:onDone(true)
end

function FightWorkListen2WorkDone:clearWork()
	self._work:disposeSelf()
end

return FightWorkListen2WorkDone
