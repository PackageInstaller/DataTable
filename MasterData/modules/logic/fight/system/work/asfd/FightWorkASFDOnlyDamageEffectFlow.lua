-- chunkname: @modules/logic/fight/system/work/asfd/FightWorkASFDOnlyDamageEffectFlow.lua

module("modules.logic.fight.system.work.asfd.FightWorkASFDOnlyDamageEffectFlow", package.seeall)

local FightWorkASFDOnlyDamageEffectFlow = class("FightWorkASFDOnlyDamageEffectFlow", BaseWork)

function FightWorkASFDOnlyDamageEffectFlow:ctor(fightStepData)
	self.fightStepData = fightStepData
end

local OnlyHandleEffect = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true
}

function FightWorkASFDOnlyDamageEffectFlow:onStart()
	local flow = FightWorkFlowSequence.New()

	self:addFightStepDamageWork(flow, self.fightStepData)

	local stepWork = FightStepEffectWork.New()

	stepWork:setFlow(flow)

	self.stepWork = stepWork

	if not self.stepWork then
		return self:onDone(true)
	end

	self.stepWork:registerDoneListener(self.onEffectWorkDone, self)
	self.stepWork:onStartInternal()
end

function FightWorkASFDOnlyDamageEffectFlow:addFightStepDamageWork(flow, fightStepData)
	if not fightStepData then
		return
	end

	for i, actEffectData in ipairs(fightStepData.actEffect) do
		local effectType = actEffectData.effectType

		if not actEffectData:isDone() then
			if effectType == FightEnum.EffectType.FIGHTSTEP then
				self:addFightStepDamageWork(flow, actEffectData.fightStep)
			elseif OnlyHandleEffect[effectType] then
				local class = FightStepBuilder.EffectType2FlowOrWork[effectType]

				if class then
					flow:registWork(class, fightStepData, actEffectData)
				end
			end
		end
	end
end

function FightWorkASFDOnlyDamageEffectFlow:onEffectWorkDone()
	return self:onDone(true)
end

function FightWorkASFDOnlyDamageEffectFlow:clearWork()
	if self.stepWork then
		self.stepWork:clearWork()

		self.stepWork = nil
	end
end

return FightWorkASFDOnlyDamageEffectFlow
