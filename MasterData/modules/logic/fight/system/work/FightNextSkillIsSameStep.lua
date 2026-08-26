-- chunkname: @modules/logic/fight/system/work/FightNextSkillIsSameStep.lua

module("modules.logic.fight.system.work.FightNextSkillIsSameStep", package.seeall)

local FightNextSkillIsSameStep = class("FightNextSkillIsSameStep", BaseWork)

function FightNextSkillIsSameStep:ctor(fightStepData, preStepData)
	self.fightStepData = fightStepData
	self.preStepData = preStepData

	FightController.instance:registerCallback(FightEvent.CheckPlaySameSkill, self._checkPlaySameSkill, self)
end

function FightNextSkillIsSameStep:onStart()
	self:onDone(true)
end

function FightNextSkillIsSameStep:_checkPlaySameSkill(playingFightStepData, paramsArr)
	if playingFightStepData ~= self.preStepData then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)

	if not entityMO then
		return
	end

	if self.fightStepData.fromId ~= self.preStepData.fromId then
		return
	end

	local entityMO1 = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)
	local entityMO2 = FightDataHelper.entityMgr:getById(self.preStepData.fromId)

	if entityMO1.side ~= entityMO2.side then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		if self.fightStepData.actId ~= self.preStepData.actId then
			local skillIdDict = SkillConfig.instance:getHeroAllSkillIdDict(entityMO1.modelId)
			local pre_skill = -1
			local cur_skill

			for k, v in pairs(skillIdDict) do
				for index, skill_id in ipairs(v) do
					if skill_id == self.preStepData.actId then
						pre_skill = k
					end

					if skill_id == self.fightStepData.actId then
						cur_skill = k
					end
				end
			end

			if pre_skill ~= cur_skill then
				return
			end
		end
	elseif self.fightStepData.actId ~= self.preStepData.actId then
		local pre_skill_belong = -1
		local cur_skill_belong

		for i, v in ipairs(entityMO.skillGroup1) do
			if self.preStepData.actId == v then
				pre_skill_belong = 1
			end

			if self.fightStepData.actId == v then
				cur_skill_belong = 1
			end
		end

		for i, v in ipairs(entityMO.skillGroup2) do
			if self.preStepData.actId == v then
				pre_skill_belong = 2
			end

			if self.fightStepData.actId == v then
				cur_skill_belong = 2
			end
		end

		if pre_skill_belong ~= cur_skill_belong then
			return
		end
	end

	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, self._checkPlaySameSkill, self)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySameSkill, self.preStepData, self.fightStepData)
end

function FightNextSkillIsSameStep:clearWork()
	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, self._checkPlaySameSkill, self)
end

return FightNextSkillIsSameStep
