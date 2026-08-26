-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerPrompt.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerPrompt", package.seeall)

local FightWorkTriggerPrompt = class("FightWorkTriggerPrompt", BaseWork)

function FightWorkTriggerPrompt:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerPrompt:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	if self._config then
		FightController.instance:dispatchEvent(FightEvent.ShowFightPrompt, tonumber(self._config.param1), tonumber(self._config.param2))
	end

	self:onDone(true)
end

function FightWorkTriggerPrompt:clearWork()
	return
end

return FightWorkTriggerPrompt
