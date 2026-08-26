-- chunkname: @modules/logic/fight/system/work/FightEffectBase.lua

module("modules.logic.fight.system.work.FightEffectBase", package.seeall)

local FightEffectBase = class("FightEffectBase", FightWorkItem)

function FightEffectBase:onConstructor()
	self.skipAutoPlayData = false
end

function FightEffectBase:onLogicEnter(fightStepData, actEffectData)
	FightEffectBase.super.onLogicEnter(self, fightStepData, actEffectData)

	self.fightStepData = fightStepData
	self.actEffectData = actEffectData
end

function FightEffectBase:_fightWorkSafeTimer()
	if self.fightStepData then
		local str = string.format("战斗保底 fightwork ondone, className = %s , 步骤类型:%s, actId:%s", self.__cname, self.fightStepData.actType, self.fightStepData.actId)

		logError(str)
	end

	self:onDone(false)
end

function FightEffectBase:start(context)
	if self.actEffectData then
		if self.actEffectData:isDone() then
			self:onDone(true)

			return
		else
			xpcall(self.beforePlayEffectData, __G__TRACKBACK__, self)

			if not self.skipAutoPlayData then
				self:playEffectData()
			end
		end
	end

	return FightEffectBase.super.start(self, context)
end

function FightEffectBase:getEffectData()
	return self.actEffectData
end

function FightEffectBase:beforeStart()
	if self.actEffectData then
		FightController.instance:dispatchEvent(FightEvent.InvokeFightWorkEffectType, self.actEffectData.effectType)
	end

	FightSkillBehaviorMgr.instance:playSkillEffectBehavior(self.fightStepData, self.actEffectData)
end

function FightEffectBase:playEffectData()
	FightDataHelper.playEffectData(self.actEffectData)
end

function FightEffectBase:beforePlayEffectData()
	return
end

function FightEffectBase:beforeClearWork()
	return
end

function FightEffectBase:getAdjacentSameEffectList(parallelEffectType, detectNextStep)
	local list = {}

	table.insert(list, {
		actEffectData = self.actEffectData,
		fightStepData = self.fightStepData
	})
	xpcall(self.detectAdjacentSameEffect, __G__TRACKBACK__, self, list, parallelEffectType, detectNextStep)

	return list
end

function FightEffectBase:detectAdjacentSameEffect(list, parallelEffectType, detectNextStep)
	local actEffectData = self.actEffectData.nextActEffectData

	while actEffectData do
		local effectType = actEffectData.effectType

		if parallelEffectType and parallelEffectType[effectType] then
			if not actEffectData:isDone() then
				table.insert(list, {
					actEffectData = actEffectData,
					fightStepData = self.fightStepData
				})
			end

			actEffectData = effectType == FightEnum.EffectType.FIGHTSTEP and actEffectData.fightStepNextActEffectData or actEffectData.nextActEffectData
		elseif effectType == self.actEffectData.effectType then
			if not actEffectData:isDone() then
				table.insert(list, {
					actEffectData = actEffectData,
					fightStepData = self.fightStepData
				})
			end

			actEffectData = actEffectData.nextActEffectData
		elseif effectType == FightEnum.EffectType.FIGHTSTEP then
			actEffectData = actEffectData.nextActEffectData
		else
			return list
		end
	end

	if detectNextStep then
		local roundData = FightDataHelper.roundMgr:getRoundData()

		if not roundData then
			logError("找不到roundData")

			return list
		end

		local fightStepList = roundData.fightStep

		if not self.fightStepData.custom_stepIndex then
			return list
		end

		local stepIndex = self.fightStepData.custom_stepIndex + 1
		local nextStep = fightStepList[stepIndex]

		while nextStep do
			if FightHelper.isTimelineStep(nextStep) then
				return list
			end

			if #nextStep.actEffect == 0 then
				stepIndex = stepIndex + 1
				nextStep = fightStepList[stepIndex]
			else
				local allPassed = self:addSameEffectDetectNextStep(list, parallelEffectType, nextStep)

				if allPassed then
					stepIndex = stepIndex + 1
					nextStep = fightStepList[stepIndex]
				else
					return list
				end
			end
		end
	end

	return list
end

function FightEffectBase:addSameEffectDetectNextStep(list, parallelEffectType, nextStep)
	for i, actEffectData in ipairs(nextStep.actEffect) do
		if parallelEffectType and parallelEffectType[actEffectData.effectType] then
			if not actEffectData:isDone() then
				table.insert(list, {
					actEffectData = actEffectData,
					fightStepData = nextStep
				})
			end
		elseif actEffectData.effectType == self.actEffectData.effectType then
			if not actEffectData:isDone() then
				table.insert(list, {
					actEffectData = actEffectData,
					fightStepData = nextStep
				})
			end
		elseif actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP then
			local allPassed = self:addSameEffectDetectNextStep(list, parallelEffectType, actEffectData.fightStep)

			if not allPassed then
				return false
			end
		else
			return false
		end
	end

	return true
end

return FightEffectBase
