-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/config/V1a6_CachotCollectionConfig.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotCollectionConfig", package.seeall)

local V1a6_CachotCollectionConfig = class("V1a6_CachotCollectionConfig", BaseConfig)

function V1a6_CachotCollectionConfig:onInit()
	self._collectionConfigTable = nil
end

function V1a6_CachotCollectionConfig:reqConfigNames()
	return {
		"rogue_collection",
		"rogue_collection_enchant",
		"rogue_collecion_unlock_task"
	}
end

function V1a6_CachotCollectionConfig:onConfigLoaded(configName, configTable)
	if configName == "rogue_collection" then
		self:onRogueCollectionConfigLoaded(configTable)
	elseif configName == "rogue_collection_enchant" then
		self._enchantConfigTable = configTable
	end
end

function V1a6_CachotCollectionConfig:onRogueCollectionConfigLoaded(configTab)
	self._collectionConfigTable = configTab
	self._collectionTypeMap = self._collectionTypeMap or {}
	self._collectionGroupMap = self._collectionGroupMap or {}

	if configTab.configDict then
		for _, v in ipairs(configTab.configList) do
			self._collectionTypeMap[v.type] = self._collectionTypeMap[v.type] or {}
			self._collectionGroupMap[v.group] = self._collectionGroupMap[v.group] or {}

			table.insert(self._collectionTypeMap[v.type], v)
			table.insert(self._collectionGroupMap[v.group], v)
		end
	end
end

function V1a6_CachotCollectionConfig:getAllConfig()
	return self._collectionConfigTable.configList
end

function V1a6_CachotCollectionConfig:getCollectionConfig(id)
	if self._collectionConfigTable.configDict then
		return self._collectionConfigTable.configDict[id]
	end
end

function V1a6_CachotCollectionConfig:getCollectionConfigsByType(type)
	return self._collectionTypeMap and self._collectionTypeMap[type]
end

function V1a6_CachotCollectionConfig:getCollectionSkillsByConfig(collectionCfg)
	local skillCfgs = collectionCfg and collectionCfg.skills

	if skillCfgs then
		local skills = {}
		local skillList = GameUtil.splitString2(skillCfgs, true)

		if skillList then
			for i = 1, #skillList do
				local skillId = skillList[i][3]

				table.insert(skills, skillId)
			end
		end

		return skills
	end
end

function V1a6_CachotCollectionConfig:getCollectionSkillsInfo(collectionCfg)
	local skillCfgs = collectionCfg and collectionCfg.skills
	local skillTab = {}
	local effectTab = {}
	local effectMap = {}

	if skillCfgs then
		local skillList = GameUtil.splitString2(skillCfgs, true)

		if skillList then
			for i = 1, #skillList do
				local skillId = skillList[i][3]
				local skillCfg = lua_rule.configDict[skillId]
				local skillDesc = skillCfg and skillCfg.desc
				local descList = HeroSkillModel.instance:getEffectTagDescIdList(skillDesc)

				table.insert(skillTab, skillId)

				if descList then
					for _, effectDescId in ipairs(descList) do
						if not effectMap[effectDescId] then
							table.insert(effectTab, effectDescId)

							effectMap[effectDescId] = true
						end
					end
				end
			end
		end
	end

	return skillTab, effectTab
end

function V1a6_CachotCollectionConfig:getCollectionSkillsContent(collectionCfg, effectTagColor, percentColor, bracketColor)
	effectTagColor = effectTagColor or "#4e6698"

	local skillCfgs = collectionCfg and collectionCfg.skills
	local skillContentStr = ""

	if skillCfgs then
		local skills = {}
		local skillList = GameUtil.splitString2(skillCfgs, true)

		if skillList then
			for i = 1, #skillList do
				local skillId = skillList[i][3]
				local skillCfg = lua_rule.configDict[skillId]

				if skillCfg then
					table.insert(skills, skillCfg.desc)
				end
			end
		end

		skillContentStr = table.concat(skills, "\n")
	end

	local effectDesc = HeroSkillModel.instance:getEffectTagDescFromDescRecursion(skillContentStr, effectTagColor)

	if not string.nilorempty(effectDesc) then
		skillContentStr = skillContentStr .. "\n" .. effectDesc
	end

	skillContentStr = HeroSkillModel.instance:skillDesToSpot(skillContentStr, percentColor, bracketColor)

	return skillContentStr
end

function V1a6_CachotCollectionConfig:getCollectionSpDescsByConfig(collectionCfg)
	local spDesc = collectionCfg and collectionCfg.spdesc

	return (not string.nilorempty(spDesc) or nil) and string.split(spDesc, "#")
end

function V1a6_CachotCollectionConfig:getCollectionsByGroupId(groupId)
	return self._collectionGroupMap and self._collectionGroupMap[groupId]
end

V1a6_CachotCollectionConfig.instance = V1a6_CachotCollectionConfig.New()

return V1a6_CachotCollectionConfig
