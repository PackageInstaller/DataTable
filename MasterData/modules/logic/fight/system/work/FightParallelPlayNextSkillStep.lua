-- chunkname: @modules/logic/fight/system/work/FightParallelPlayNextSkillStep.lua

module("modules.logic.fight.system.work.FightParallelPlayNextSkillStep", package.seeall)

local FightParallelPlayNextSkillStep = class("FightParallelPlayNextSkillStep", BaseWork)

function FightParallelPlayNextSkillStep:ctor(fightStepData, preStepData, fightStepDataList)
	self.fightStepData = fightStepData
	self.preStepData = preStepData
	self.fightStepDataList = fightStepDataList

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillCheck, self._parallelPlayNextSkillCheck, self)
end

function FightParallelPlayNextSkillStep:onStart()
	self:onDone(true)
end

function FightParallelPlayNextSkillStep:_parallelPlayNextSkillCheck(playingFightStepData)
	if playingFightStepData ~= self.preStepData then
		return
	end

	local prevEntityMO = FightDataHelper.entityMgr:getById(self.preStepData.fromId)

	if not prevEntityMO then
		return
	end

	if FightCardDataHelper.isBigSkill(self.preStepData.actId) then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)

	if not entityMO then
		return
	end

	if FightCardDataHelper.isBigSkill(self.fightStepData.actId) then
		return
	end

	if FightSkillMgr.instance:isEntityPlayingTimeline(self.fightStepData.fromId) then
		return
	end

	if self.fightStepData.fromId == self.preStepData.fromId then
		return
	end

	local entityMO1 = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)
	local entityMO2 = FightDataHelper.entityMgr:getById(self.preStepData.fromId)

	if entityMO1.side ~= entityMO2.side then
		return
	end

	if self.fightStepDataList then
		local indexInMOList = tabletool.indexOf(self.fightStepDataList, playingFightStepData) or #self.fightStepDataList

		for i = indexInMOList + 1, #self.fightStepDataList do
			local oneFightStepData = self.fightStepDataList[i]

			if oneFightStepData.actType == FightEnum.ActType.EFFECT then
				for _, oneActEffectData in ipairs(oneFightStepData.actEffect) do
					local hasDead = oneActEffectData.effectType == FightEnum.EffectType.DEAD
					local isDeadEntity = playingFightStepData.fromId == oneActEffectData.targetId

					if hasDead and isDeadEntity then
						return
					end
				end
			end
		end
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, self._parallelPlayNextSkillCheck, self)

	self.fightStepData.isParallelStep = true

	FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillDoneThis, playingFightStepData)
end

function FightParallelPlayNextSkillStep:clearWork()
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, self._parallelPlayNextSkillCheck, self)
end

return FightParallelPlayNextSkillStep
