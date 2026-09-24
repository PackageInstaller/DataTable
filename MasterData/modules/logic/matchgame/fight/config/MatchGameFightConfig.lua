-- chunkname: @modules/logic/matchgame/fight/config/MatchGameFightConfig.lua

module("modules.logic.matchgame.fight.config.MatchGameFightConfig", package.seeall)

local MatchGameFightConfig = class("MatchGameFightConfig", BaseConfig)

function MatchGameFightConfig:reqConfigNames()
	return {
		"activity244_counter",
		"activity244_gem_droprate",
		"activity244_element",
		"activity244_monster",
		"activity244_monster_skill_template",
		"activity244_monster_skill",
		"activity244_monster_template",
		"activity244_monster_buff",
		"activity244_buff",
		"activity244_skill_target",
		"activity244_skill_effect",
		"activity244_skill_condition",
		"activity244_skill_buff",
		"activity244_skill_range"
	}
end

function MatchGameFightConfig:onConfigLoaded(configName, configTable)
	local func = self["process_" .. configName]

	if func then
		func(self, configTable)
	end
end

function MatchGameFightConfig:initChainRateDataList(activityId)
	self.chainRateDataList = {}

	local chainStr = MatchGameConfig.instance:getConstValue(activityId, MatchGameFightEnum.ConstId.ChainRate)
	local chainDataList = GameUtil.splitString2(chainStr, true)

	for index, chainCoData in ipairs(chainDataList) do
		local chainData = {}

		chainData.index = index
		chainData.minChainNum = tonumber(chainCoData[1])
		chainData.maxChainNum = tonumber(chainCoData[2])
		chainData.rate = tonumber(chainCoData[3])

		table.insert(self.chainRateDataList, chainData)
	end
end

function MatchGameFightConfig:getChainRate(activityId, chainNum)
	if not next(self.chainRateDataList) then
		self:initChainRateDataList(activityId)
	end

	for _, chainData in ipairs(self.chainRateDataList) do
		if chainNum >= chainData.minChainNum and chainNum <= chainData.maxChainNum then
			return chainData.rate, chainData.index
		elseif chainNum > chainData.maxChainNum and chainData.minChainNum > 0 and chainData.minChainNum == chainData.maxChainNum then
			return chainData.rate, chainData.index
		end
	end

	return 0, 1
end

function MatchGameFightConfig:getChainRateDataList()
	return self.chainRateDataList
end

function MatchGameFightConfig:process_activity244_counter(configTable)
	self._counterConfig = configTable
end

function MatchGameFightConfig:getCounterRate(attackCareerId, defCareerId)
	for _, config in ipairs(self._counterConfig.configList) do
		if config.attackerCareer == attackCareerId and config.defenderCareer == defCareerId then
			return tonumber(config.multiplier)
		end
	end

	return 1
end

function MatchGameFightConfig:process_activity244_gem_droprate(configTable)
	self._gemDropRateConfig = configTable
	self._gemDropRateDataMap = {}
end

function MatchGameFightConfig:getDropRateConfig(gemTemplateId)
	local dropRateData = self._gemDropRateDataMap[gemTemplateId]

	if not dropRateData then
		for _, config in ipairs(self._gemDropRateConfig.configList) do
			local dropRateData = {}

			dropRateData.id = config.gemTemplateId
			dropRateData.healDropRate = config.healDropRate
			dropRateData.bombDropRate = config.bombDropRate
			dropRateData.boxDropRateDataList = config.boxDropRate == "0" and {} or GameUtil.splitString2(config.boxDropRate, true)
			self._gemDropRateDataMap[config.gemTemplateId] = dropRateData
		end
	end

	return self._gemDropRateDataMap[gemTemplateId]
end

function MatchGameFightConfig:process_activity244_monster(configTable)
	self._monsterConfig = configTable
end

function MatchGameFightConfig:getMonsterConfig(monsterId)
	return self._monsterConfig.configDict[monsterId]
end

function MatchGameFightConfig:process_activity244_monster_skill_template(configTable)
	self._monsterSkillTemplateConfig = configTable
end

function MatchGameFightConfig:getMonsterSkillTemplateConfig(monsterId)
	return self._monsterSkillTemplateConfig.configDict[monsterId]
end

function MatchGameFightConfig:process_activity244_monster_skill(configTable)
	self._monsterSkillConfig = configTable
end

function MatchGameFightConfig:getMonsterSkillConfig(skillId)
	return self._monsterSkillConfig.configDict[skillId]
end

function MatchGameFightConfig:process_activity244_monster_template(configTable)
	self._monsterAttrConfig = configTable
end

function MatchGameFightConfig:getMonsterAttrConfig(attrId)
	return self._monsterAttrConfig.configDict[attrId]
end

function MatchGameFightConfig:process_activity244_monster_buff(configTable)
	self._monsterBuffConfig = configTable
end

function MatchGameFightConfig:getMonsterBuffConfig(buffId)
	return self._monsterBuffConfig.configDict[buffId]
end

function MatchGameFightConfig:process_activity244_buff(configTable)
	self._buffConfig = configTable
end

function MatchGameFightConfig:getHeroBuffConfig(buffId)
	return self._buffConfig.configDict[buffId]
end

function MatchGameFightConfig:process_activity244_element(configTable)
	self._elementConfig = configTable
end

function MatchGameFightConfig:getElementConfig(elementId)
	return self._elementConfig.configDict[elementId]
end

function MatchGameFightConfig:getElementId(type, param)
	for _, config in ipairs(self._elementConfig.configList) do
		if config.type == type and config.param == tostring(param) then
			return config.elementId
		end
	end

	return nil
end

function MatchGameFightConfig:process_activity244_skill_target(configTable)
	self._skillTargetConfig = configTable
end

function MatchGameFightConfig:getSkillTargetConfig(targetId)
	return self._skillTargetConfig.configDict[targetId]
end

function MatchGameFightConfig:process_activity244_skill_effect(configTable)
	self._skillEffectConfig = configTable
end

function MatchGameFightConfig:getSkillEffectConfig(effectId)
	return self._skillEffectConfig.configDict[effectId]
end

function MatchGameFightConfig:process_activity244_skill_condition(configTable)
	self._skillConditionConfig = configTable
end

function MatchGameFightConfig:getSkillConditionConfig(conditionId)
	return self._skillConditionConfig.configDict[conditionId]
end

function MatchGameFightConfig:process_activity244_skill_buff(configTable)
	self._skillBuffConfig = configTable
end

function MatchGameFightConfig:getSkillBuffConfig(buffId)
	return self._skillBuffConfig.configDict[buffId]
end

function MatchGameFightConfig:process_activity244_skill_range(configTable)
	self._skillRangeConfig = configTable
end

function MatchGameFightConfig:getSkillRangeConfig(rangeId)
	return self._skillRangeConfig.configDict[rangeId]
end

function MatchGameFightConfig:checkSkillContainCondition(skillId, userType, conditionId)
	local skillConfig = self:getMonsterSkillConfig(skillId)

	if userType == MatchGameFightEnum.SkillUserType.Hero then
		skillConfig = MatchGameConfig.instance:getHeroSkillConfig(skillId)
	end

	for index = 1, MatchGameFightEnum.MaxSkillIndex do
		local effectStr = skillConfig["effect" .. index]

		if not string.nilorempty(effectStr) then
			local conditionStr = skillConfig["condition" .. index]
			local conditionCoDataList = not string.nilorempty(conditionStr) and GameUtil.splitString2(conditionStr, true) or {}

			for _, conditionCoData in ipairs(conditionCoDataList) do
				if conditionCoData[1] == conditionId then
					return true
				end
			end
		end
	end

	return false
end

MatchGameFightConfig.instance = MatchGameFightConfig.New()

return MatchGameFightConfig
