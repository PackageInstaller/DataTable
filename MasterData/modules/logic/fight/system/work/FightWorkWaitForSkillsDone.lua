-- chunkname: @modules/logic/fight/system/work/FightWorkWaitForSkillsDone.lua

module("modules.logic.fight.system.work.FightWorkWaitForSkillsDone", package.seeall)

local FightWorkWaitForSkillsDone = class("FightWorkWaitForSkillsDone", BaseWork)

function FightWorkWaitForSkillsDone:ctor(skillFlowList)
	self._skillFlowList = skillFlowList
end

function FightWorkWaitForSkillsDone:onStart(context)
	if self:_checkDone() then
		self:onDone(true)
	else
		local speed = FightModel.instance:getSpeed()
		local uiSpeed = FightModel.instance:getUISpeed()
		local minSpeed = math.min(speed, uiSpeed)
		local timeoutDelay = 5 / Mathf.Clamp(minSpeed, 0.01, 1)

		TaskDispatcher.runRepeat(self._onTick, self, 0.1)
		TaskDispatcher.runDelay(self._timeOut, self, timeoutDelay)
	end
end

function FightWorkWaitForSkillsDone:_onTick()
	if self:_checkDone() then
		self:onDone(true)
	end
end

function FightWorkWaitForSkillsDone:_timeOut()
	if self._skillFlowList then
		for _, skillFlow in ipairs(self._skillFlowList) do
			if not skillFlow:hasDone() then
				logError("检测回合技能完成超时，技能id = " .. skillFlow.fightStepData.actId)
			end
		end
	end

	self:onDone(true)
end

function FightWorkWaitForSkillsDone:_checkDone()
	if self._skillFlowList then
		for _, skillFlow in ipairs(self._skillFlowList) do
			if not skillFlow:hasDone() then
				return false
			end
		end
	end

	return true
end

function FightWorkWaitForSkillsDone:clearWork()
	self._skillFlowList = nil

	TaskDispatcher.cancelTask(self._onTick, self)
	TaskDispatcher.cancelTask(self._timeOut, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
end

return FightWorkWaitForSkillsDone
