-- chunkname: @modules/logic/fight/view/work/FightAutoDetectForceEndWork.lua

module("modules.logic.fight.view.work.FightAutoDetectForceEndWork", package.seeall)

local FightAutoDetectForceEndWork = class("FightAutoDetectForceEndWork", BaseWork)

function FightAutoDetectForceEndWork:ctor()
	return
end

function FightAutoDetectForceEndWork:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 1)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		FightController.instance:dispatchEvent(FightEvent.ForceEndAutoCardFlow)
	end

	self:onDone(true)
end

function FightAutoDetectForceEndWork:_delayDone()
	self:onDone(true)
end

function FightAutoDetectForceEndWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightAutoDetectForceEndWork
