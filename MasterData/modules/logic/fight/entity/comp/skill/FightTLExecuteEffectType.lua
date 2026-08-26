-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLExecuteEffectType.lua

module("modules.logic.fight.entity.comp.skill.FightTLExecuteEffectType", package.seeall)

local FightTLExecuteEffectType = class("FightTLExecuteEffectType", FightTimelineTrackItem)

function FightTLExecuteEffectType:onTrackStart(fightStepData, duration, paramsArr)
	self.duration = duration
	self.effectType = tonumber(paramsArr[1])

	if not self.effectType then
		return
	end

	self.flow = FightWorkFlowSequence.New()

	self:addFightStepEffectWork(self.flow, self.fightStepData, self.effectType)
	self.flow:start()
end

function FightTLExecuteEffectType:addFightStepEffectWork(flow, fightStepData, effectType)
	if not fightStepData then
		return
	end

	for i, actEffectData in ipairs(fightStepData.actEffect) do
		if not actEffectData:isDone() then
			if actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP then
				self:addFightStepDamageWork(flow, actEffectData.fightStep)
			elseif actEffectData.effectType == effectType then
				local class = FightStepBuilder.EffectType2FlowOrWork[effectType]

				if class then
					flow:registWork(class, fightStepData, actEffectData)
				end
			end
		end
	end
end

function FightTLExecuteEffectType:onTrackEnd()
	return
end

function FightTLExecuteEffectType:onDestructor()
	if self.flow then
		self.flow:disposeSelf()

		self.flow = nil
	end
end

return FightTLExecuteEffectType
