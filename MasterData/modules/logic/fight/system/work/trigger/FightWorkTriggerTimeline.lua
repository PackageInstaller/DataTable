-- chunkname: @modules/logic/fight/system/work/trigger/FightWorkTriggerTimeline.lua

module("modules.logic.fight.system.work.trigger.FightWorkTriggerTimeline", package.seeall)

local FightWorkTriggerTimeline = class("FightWorkTriggerTimeline", BaseWork)

function FightWorkTriggerTimeline:ctor(fightStepData, actEffectData)
	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightWorkTriggerTimeline:onStart()
	self._config = lua_trigger_action.configDict[self.actEffectData.effectNum]

	local monsterId = tonumber(self._config.param1)
	local entity = FightHelper.getEnemyEntityByMonsterId(monsterId)

	if monsterId == 0 then
		entity = FightHelper.getEntity(FightEntityScene.MySideId)
	end

	if entity and entity.skill then
		self._entityId = entity.id

		local temp_data = {
			actId = 0,
			stepUid = 0,
			actEffect = {
				{
					targetId = self._entityId
				}
			},
			fromId = self._entityId,
			toId = self.fightStepData.toId,
			actType = FightEnum.ActType.SKILL
		}

		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
		TaskDispatcher.runDelay(self._delayDone, self, 20)
		entity.skill:playTimeline(self._config.param2, temp_data)

		return
	end

	self:_delayDone()
end

function FightWorkTriggerTimeline:_delayDone()
	self:onDone(true)
end

function FightWorkTriggerTimeline:_onSkillPlayFinish(entity)
	if entity.id == self._entityId then
		self:_delayDone()
	end
end

function FightWorkTriggerTimeline:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
end

return FightWorkTriggerTimeline
