-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerDelay.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerDelay", package.seeall)

local FightWorkTriggerDelay = class("FightWorkTriggerDelay", BaseWork)

function FightWorkTriggerDelay:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerDelay:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	if self._config then
		self._startTime = ServerTime.now()
		self._delayTime = self._config.param1 / 1000

		FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
		TaskDispatcher.runDelay(self._delay, self, self._delayTime / FightModel.instance:getSpeed())
	else
		self:onDone(true)
	end
end

function FightWorkTriggerDelay:_onUpdateSpeed()
	local offset = ServerTime.now() - self._startTime

	TaskDispatcher.runDelay(self._delay, self, (self._delayTime - offset) / FightModel.instance:getSpeed())
end

function FightWorkTriggerDelay:_delay()
	self:onDone(true)
end

function FightWorkTriggerDelay:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)
	TaskDispatcher.cancelTask(self._delay, self)
end

return FightWorkTriggerDelay
