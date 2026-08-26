-- chunkname: @modules/logic/fight/system/work/FightWorkPlayNormalWork.lua

module("modules.logic.fight.system.work.FightWorkPlayNormalWork", package.seeall)

local FightWorkPlayNormalWork = class("FightWorkPlayNormalWork", FightWorkItem)

function FightWorkPlayNormalWork:onConstructor(normalWork)
	self.normalWork = normalWork
end

function FightWorkPlayNormalWork:onStart()
	self.normalWork:registerDoneListener(self.finishWork, self)
	self:cancelFightWorkSafeTimer()

	return self.normalWork:onStartInternal(self.context)
end

function FightWorkPlayNormalWork:finishWork()
	if not self:__isActive() then
		return
	end

	self:onDone(true)
end

function FightWorkPlayNormalWork:onDestructor()
	if self.normalWork.status ~= WorkStatus.Done then
		self.normalWork:onDestroyInternal()
	end
end

return FightWorkPlayNormalWork
