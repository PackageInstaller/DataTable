-- chunkname: @modules/logic/rouge2/start/config/Rouge2_CollectionConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_CollectionConfig", package.seeall)

local Rouge2_CollectionConfig = class("Rouge2_CollectionConfig", BaseConfig)

function Rouge2_CollectionConfig:onInit()
	return
end

function Rouge2_CollectionConfig:reqConfigNames()
	return {
		"rouge2_relics",
		"rouge2_active_skill",
		"rouge2_buff",
		"rouge2_tag",
		"rouge2_quality",
		"rouge2_relics_attr"
	}
end

function Rouge2_CollectionConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_tag" then
		self:_onLoadedTagConfigs(configTable)
	elseif configName == "rouge2_relics_attr" then
		self:_onLoadedAttrConfigs(configTable)
	elseif configName == "rouge2_relics" then
		self:_onLoadRelicsConfigs(configTable)
	elseif configName == "rouge2_active_skill" then
		self:_onLoadActiveSkillConfigs(configTable)
	end
end

function Rouge2_CollectionConfig:_onLoadedTagConfigs(configTable)
	self._baseTagList = {}
	self._extraTagList = {}

	for _, tagCo in ipairs(configTable.configList) do
		if tagCo.id < Rouge2_OutsideEnum.MinCollectionExtraTagID then
			table.insert(self._baseTagList, tagCo)
		else
			table.insert(self._extraTagList, tagCo)
		end
	end
end

function Rouge2_CollectionConfig:_onLoadedAttrConfigs(configTable)
	self._flagName2ConfigMap = {}

	for _, flagCo in ipairs(configTable.configList) do
		local flagName = flagCo.flag

		if self._flagName2ConfigMap[flagName] then
			logNormal(string.format("肉鸽构筑物属性表配置错误, 存在相同的flag, id = %s, flag = %s", flagCo.id, flagCo.flag))
		else
			self._flagName2ConfigMap[flagName] = flagCo
		end
	end
end

function Rouge2_CollectionConfig:_onLoadRelicsConfigs(configTable)
	self._attr2RelicsMap = {}
	self._updateId2BaseRelicsMap = {}

	for _, relicsCo in ipairs(configTable.configList) do
		local attrUpdate = relicsCo.attrUpdate

		if not string.nilorempty(attrUpdate) then
			local attrUpdateInfo = string.splitToNumber(attrUpdate, "#")

			if not attrUpdateInfo[1] then
				if not attrUpdateInfo[2] then
					local attrValue = 0

					self._attr2RelicsMap[attrUpdateInfo[1]] = self._attr2RelicsMap[attrUpdateInfo[1]] or {}

					table.insert(self._attr2RelicsMap[attrUpdateInfo[1]], {
						attrValue = attrValue,
						config = relicsCo
					})

					local updateId = relicsCo.updateId

					if updateId and updateId ~= 0 then
						self._updateId2BaseRelicsMap[updateId] = relicsCo.id
					end
				end
			end
		end
	end

	for _, relicsList in pairs(self._attr2RelicsMap) do
		table.sort(relicsList, self._relicsSortFunc)
	end
end

function Rouge2_CollectionConfig._relicsSortFunc(aInfo, bInfo)
	local aAttrValue = aInfo.attrValue
	local bAttrValue = bInfo.attrValue

	if aAttrValue ~= bAttrValue then
		return aAttrValue < bAttrValue
	end

	local aRelicsCo = aInfo.config
	local bRelcisCo = bInfo.config

	if aRelicsCo then
		if not aRelicsCo.rare then
			local aRelicsRare = 0

			if bRelcisCo then
				if not bRelcisCo.rare then
					local bRelicsRare = 0

					if aRelicsRare ~= bRelicsRare then
						return aRelicsRare < bRelicsRare
					end

					return aRelicsCo.id < bRelcisCo.id
				end
			end
		end
	end
end

function Rouge2_CollectionConfig:_onLoadActiveSkillConfigs(configTable)
	self._skillId2UpdateAttrList = {}
	self._skillId2UpdateAttrMap = {}
	self._skillType2LevelUpSkillList = {}
	self._skillId2TrialHeroList = {}

	for _, skillCo in ipairs(configTable.configList) do
		local skillId = skillCo.id
		local updateAttrList = GameUtil.splitString2(skillCo.updateAttri, true)

		if updateAttrList then
			local updateAttrMap = {}

			self._skillId2UpdateAttrList[skillId] = updateAttrList
			self._skillId2UpdateAttrMap[skillId] = updateAttrMap

			for _, attrInfo in ipairs(updateAttrList) do
				updateAttrMap[attrInfo[1]] = attrInfo[2] or 0
			end
		end

		local skillType = skillCo.skillTypeName

		if skillType and skillType ~= 0 then
			self._skillType2LevelUpSkillList[skillType] = self._skillType2LevelUpSkillList[skillType] or {}

			table.insert(self._skillType2LevelUpSkillList[skillType], skillCo)
		end

		self._skillId2TrialHeroList[skillId] = GameUtil.splitString2(skillCo.hero_trial, true)
	end

	for _, skillList in pairs(self._skillType2LevelUpSkillList) do
		table.sort(skillList, self._levelUpSkillSortFunc)
	end
end

function Rouge2_CollectionConfig._levelUpSkillSortFunc(aSkillCo, bSkillCo)
	local aRare = aSkillCo.rare
	local bRare = bSkillCo.rare

	if aRare ~= bRare then
		return aRare < bRare
	end

	return aSkillCo.id < bSkillCo.id
end

function Rouge2_CollectionConfig:getRelicsConfig(relicsId)
	local relicsCo = relicsId and lua_rouge2_relics.configDict[relicsId]

	if not relicsCo then
		logNormal(string.format("肉鸽造物配置不存在 relicsId = %s", relicsId))
	end

	return relicsCo
end

function Rouge2_CollectionConfig:getRelicsTagIds(relicsId)
	local relicsCo = self:getRelicsConfig(relicsId)

	if relicsCo then
		if not relicsCo.tag then
			local tagIdStr = ""

			return string.splitToNumber(tagIdStr, "#")
		end
	end
end

function Rouge2_CollectionConfig:getActiveSkillConfig(skillId)
	local skillCo = skillId and lua_rouge2_active_skill.configDict[skillId]

	if not skillCo then
		logNormal(string.format("肉鸽主动技能配置不存在 skillId = %s", skillId))
	end

	return skillCo
end

function Rouge2_CollectionConfig:getAllTags()
	return lua_rouge2_tag.configList
end

function Rouge2_CollectionConfig:getTagConfig(tagId)
	local tagCo = lua_rouge2_tag.configDict[tagId]

	if not tagCo then
		logNormal(string.format("肉鸽构造物标签配置不存在 tagId = %s", tagId))
	end

	return tagCo
end

function Rouge2_CollectionConfig:getBuffConfig(buffId)
	local buffCo = lua_rouge2_buff.configDict[buffId]

	if not buffCo then
		logNormal(string.format("肉鸽谐波配置不存在 buffId = %s", buffId))
	end

	return buffCo
end

function Rouge2_CollectionConfig:getCollectionName(collectionId)
	local relicsCo = self:getRelicsConfig(collectionId)

	return relicsCo and relicsCo.name
end

function Rouge2_CollectionConfig:getRareConfig(rareId)
	local rareCo = lua_rouge2_quality.configDict[rareId]

	if not rareCo then
		logNormal(string.format("肉鸽品质配置不存在 rareId = %s", rareId))
	end

	return rareCo
end

function Rouge2_CollectionConfig:getRareName(rareId)
	local rareCo = self:getRareConfig(rareId)

	return (rareCo or nil) and (rareCo.name or "")
end

function Rouge2_CollectionConfig:getCollectionBaseTags()
	return self._baseTagList
end

function Rouge2_CollectionConfig:getCollectionExtraTags()
	return self._extraTagList
end

function Rouge2_CollectionConfig:getAttrMap()
	return lua_rouge2_relics_attr.configDict
end

function Rouge2_CollectionConfig:getAttrFlagConfigByName(flagName)
	if self._flagName2ConfigMap then
		if not self._flagName2ConfigMap then
			logNormal(string.format("肉鸽构筑物属性表配置不存在 flagName = %s", flagName))
		end

		return self._flagName2ConfigMap
	end
end

function Rouge2_CollectionConfig:getAttrUpdateRelicsList(attrId)
	return self._attr2RelicsMap[attrId]
end

function Rouge2_CollectionConfig:getBaseRelicsId(updateId)
	if self._updateId2BaseRelicsMap then
		return self._updateId2BaseRelicsMap
	end
end

function Rouge2_CollectionConfig:getSkillUpdateAttrList(skillId)
	if self._skillId2UpdateAttrList then
		return self._skillId2UpdateAttrList
	end
end

function Rouge2_CollectionConfig:getMaxSkillUpdateAttrList(skillId)
	local findSkillId = skillId
	local updateAttrList
	local maxFindDepth = 10

	while findSkillId and findSkillId ~= 0 and maxFindDepth > 0 do
		updateAttrList = self:getSkillUpdateAttrList(findSkillId)

		if updateAttrList then
			if not #updateAttrList then
				local updateAttrNum = 0

				if updateAttrNum > 0 then
					break
				end

				maxFindDepth = maxFindDepth - 1
				findSkillId = self:getPreLevelActiveSkillId(findSkillId)
			end
		end
	end

	return updateAttrList or {}
end

function Rouge2_CollectionConfig:isSkillUpdateAttr(skillId, attrId)
	if self._skillId2UpdateAttrMap then
		local attrUpdateMap = self._skillId2UpdateAttrMap[skillId]
		local attrUpdateValue = attrUpdateMap and attrUpdateMap[attrId]

		return attrUpdateValue and attrUpdateValue ~= 0
	end
end

function Rouge2_CollectionConfig:getSkillListBySkillType(skillType)
	if self._skillType2LevelUpSkillList then
		return self._skillType2LevelUpSkillList
	end
end

function Rouge2_CollectionConfig:getPreLevelActiveSkillId(skillId)
	local skillCo = self:getActiveSkillConfig(skillId)
	local skillType = skillCo and skillCo.skillTypeName
	local skillList = self:getSkillListBySkillType(skillType)

	if skillList then
		for i = 2, #skillList do
			if skillList[i].id == skillId then
				return skillList[i - 1].id
			end
		end
	end
end

function Rouge2_CollectionConfig:getTrialHeroListBySkillId(skillId)
	return self._skillId2TrialHeroList and self._skillId2TrialHeroList[skillId]
end

function Rouge2_CollectionConfig:getItemBattleTagMap(itemId)
	local tagTab = self:_getOrCreateItemBattleTagTab(itemId)

	return (tagTab or nil) and (tagTab.map or {})
end

function Rouge2_CollectionConfig:getItemBattleTagList(itemId)
	local tagTab = self:_getOrCreateItemBattleTagTab(itemId)

	return (tagTab or nil) and (tagTab.list or {})
end

function Rouge2_CollectionConfig:_getOrCreateItemBattleTagTab(itemId)
	if self._itemBattleTagCache then
		local tagTab = self._itemBattleTagCache[itemId]

		if not self._itemBattleTagCache then
			local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)

			if itemCo then
				if not itemCo.battleTag then
					local battleTag = ""
					local tagList = string.splitToNumber(battleTag, "|")
					local tagMap = {}

					for _, tagId in ipairs(tagList) do
						tagMap[tagId] = true
					end

					tagTab = {
						list = tagList,
						map = tagMap
					}
					self._itemBattleTagCache = self._itemBattleTagCache or {}
					self._itemBattleTagCache[itemId] = self._itemBattleTagCache
				end
			end
		end

		return self._itemBattleTagCache
	end
end

Rouge2_CollectionConfig.instance = Rouge2_CollectionConfig.New()

return Rouge2_CollectionConfig
