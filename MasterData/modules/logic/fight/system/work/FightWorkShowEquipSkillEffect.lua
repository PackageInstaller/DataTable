-- chunkname: @modules/logic/fight/system/work/FightWorkShowEquipSkillEffect.lua

module("modules.logic.fight.system.work.FightWorkShowEquipSkillEffect", package.seeall)

local FightWorkShowEquipSkillEffect = class("FightWorkShowEquipSkillEffect", BaseWork)

function FightWorkShowEquipSkillEffect:ctor(fightStepData)
	self.fightStepData = fightStepData

	local roundData = FightDataHelper.roundMgr:getRoundData()
	local fightStepList = roundData and roundData.fightStep
	local index

	self._nextStepData = fightStepList and fightStepList[(self.fightStepData.custom_stepIndex or nil) and self.fightStepData.custom_stepIndex + 1]
end

function FightWorkShowEquipSkillEffect:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)

	if self.fightStepData.actType == FightEnum.ActType.SKILL and not FightDataHelper.stateMgr.isReplay then
		local equip_skill_config = EquipConfig.instance:isEquipSkill(self.fightStepData.actId)

		if equip_skill_config then
			if self.fightStepData.actEffect and #self.fightStepData.actEffect == 1 then
				local actEffectData = self.fightStepData.actEffect[1]

				if actEffectData.effectType == FightEnum.EffectType.BUFFADD and actEffectData.buff then
					local buffConfig = lua_skill_buff.configDict[actEffectData.buff.buffId]

					if buffConfig and string.nilorempty(buffConfig.features) then
						self:onDone(true)

						return
					end
				end
			end

			FightController.instance:dispatchEvent(FightEvent.OnFloatEquipEffect, self.fightStepData.fromId, equip_skill_config)

			if self._nextStepData and self._nextStepData.fromId == self.fightStepData.fromId and FightCardDataHelper.isActiveSkill(self._nextStepData.fromId, self._nextStepData.actId) then
				TaskDispatcher.runDelay(self._delayDone, self, 0.5 / FightModel.instance:getUISpeed())

				return
			end
		end
	end

	self:onDone(true)
end

function FightWorkShowEquipSkillEffect:_delayDone()
	self:onDone(true)
end

function FightWorkShowEquipSkillEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkShowEquipSkillEffect
