-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerAudio.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerAudio", package.seeall)

local FightWorkTriggerAudio = class("FightWorkTriggerAudio", BaseWork)

function FightWorkTriggerAudio:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerAudio:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	AudioMgr.instance:trigger(tonumber(self._config.param1))
	self:_delayDone()
end

function FightWorkTriggerAudio:_delayDone()
	self:onDone(true)
end

function FightWorkTriggerAudio:clearWork()
	return
end

return FightWorkTriggerAudio
