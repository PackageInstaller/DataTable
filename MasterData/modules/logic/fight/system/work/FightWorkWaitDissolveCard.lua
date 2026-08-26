-- chunkname: @modules/logic/fight/system/work/FightWorkWaitDissolveCard.lua

module("modules.logic.fight.system.work.FightWorkWaitDissolveCard", package.seeall)

local FightWorkWaitDissolveCard = class("FightWorkWaitDissolveCard", BaseWork)

function FightWorkWaitDissolveCard:ctor(fightStepData, actEffectData, isDeadInSkill)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
	self._isDeadInSkill = isDeadInSkill
end

function FightWorkWaitDissolveCard:onStart()
	local version = FightModel.instance:getVersion()

	if version >= 1 then
		self:onDone(true)

		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if not entityMO or entityMO.side ~= FightEnum.EntitySide.MySide then
		self:onDone(true)

		return
	end

	if self._isDeadInSkill then
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	else
		local uiSpeed = FightModel.instance:getUISpeed()
		local delay = 0.5 / Mathf.Clamp(uiSpeed, 0.01, 100)

		TaskDispatcher.runDelay(self._waitForCardDissolveStart, self, delay)
	end
end

function FightWorkWaitDissolveCard:_onSkillPlayFinish(entity, skillId, fightStepData, timelineName)
	if fightStepData == self.fightStepData then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

		local uiSpeed = FightModel.instance:getUISpeed()
		local delay = 0.5 / Mathf.Clamp(uiSpeed, 0.01, 100)

		TaskDispatcher.runDelay(self._waitForCardDissolveStart, self, delay)
	end
end

function FightWorkWaitDissolveCard:_waitForCardDissolveStart()
	self:onDone(true)
end

function FightWorkWaitDissolveCard:_onCombineCardEnd()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.runDelay(self._delayDone, self, 0.1 / FightModel.instance:getUISpeed())
end

function FightWorkWaitDissolveCard:_timeOut()
	logNormal("FightWorkWaitDissolveCard 奇怪，超时结束 done")
	self:onDone(true)
end

function FightWorkWaitDissolveCard:_delayDone()
	self:onDone(true)
end

function FightWorkWaitDissolveCard:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineCardEnd, self)
	TaskDispatcher.cancelTask(self._waitForCardDissolveStart, self)
	TaskDispatcher.cancelTask(self._timeOut, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkWaitDissolveCard
