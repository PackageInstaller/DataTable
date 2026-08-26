-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/entity/EnemyBehaviorData.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyBehaviorData", package.seeall)

local EnemyBehaviorData = class("EnemyBehaviorData")

function EnemyBehaviorData:ctor()
	self._cd = 0
	self._skillList = {}
	self._skillProbability = {}
	self._needReGenerate = false
end

function EnemyBehaviorData:cd()
	return self._cd
end

function EnemyBehaviorData:init(config)
	self._cd = config.round or 0

	for i = 1, 3 do
		local skillIds = config["list" .. i]

		if skillIds ~= "" then
			local skillIdList = string.splitToNumber(skillIds, "#")

			if skillIdList ~= nil then
				table.insert(self._skillList, skillIdList)
			end
		end

		local probability = config["prob" .. i]

		if probability ~= "" then
			local probabilityList = string.splitToNumber(probability, "#")

			if probabilityList ~= nil then
				table.insert(self._skillProbability, probabilityList)
			end
		end
	end
end

function EnemyBehaviorData:getSkillList(needClear)
	self:_generateUseSkillList()

	if needClear then
		self._needReGenerate = true
	end

	return self._needReleaseSkillList
end

function EnemyBehaviorData:_generateUseSkillList()
	local needGenerate = self._needReleaseSkillList == nil or self._needReGenerate

	if self._needReleaseSkillList == nil then
		self._needReleaseSkillList = {}
	end

	if self._needReGenerate then
		tabletool.clear(self._needReleaseSkillList)

		self._needReGenerate = false
	end

	if needGenerate then
		for i = 1, #self._skillList do
			local skills = self._skillList[i]
			local skillId = skills[1]

			if #skills > 1 then
				local probability = self._skillProbability[i]
				local index = EliminateModelUtils.getRandomNumberByWeight(probability)

				skillId = skills[index]
			end

			if skillId ~= nil then
				local skill = LengZhou6SkillUtils.instance.createSkill(skillId)

				table.insert(self._needReleaseSkillList, skill)
			end
		end
	end
end

return EnemyBehaviorData
