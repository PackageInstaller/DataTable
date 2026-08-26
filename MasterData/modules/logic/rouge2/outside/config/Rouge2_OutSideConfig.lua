-- chunkname: @modules/logic/rouge2/outside/config/Rouge2_OutSideConfig.lua

module("modules.logic.rouge2.outside.config.Rouge2_OutSideConfig", package.seeall)

local Rouge2_OutSideConfig = class("Rouge2_OutSideConfig", BaseConfig)

function Rouge2_OutSideConfig:onInit()
	return
end

function Rouge2_OutSideConfig:reqConfigNames()
	return {
		"rouge2_outside_const",
		"rouge2_genius_type",
		"rouge2_genius",
		"rouge2_reward",
		"rouge2_story_list",
		"rouge2_illustration_list",
		"rouge2_material",
		"rouge2_formula",
		"rouge2_special_event",
		"rouge2_shop_date",
		"rouge2_job_level"
	}
end

function Rouge2_OutSideConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_outside_const" then
		self._outSideConstConfig = configTable
	elseif configName == "rouge2_genius_type" then
		self._geniusTypeConfig = configTable
	elseif configName == "rouge2_genius" then
		self._geniusConfig = configTable

		self:initTalentTypeConfig()
	elseif configName == "rouge2_reward" then
		self._rewardConfig = configTable

		self:initRewardConfig()
	elseif configName == "rouge2_story_list" then
		self._storyListConfig = configTable

		self:initStoryList()
	elseif configName == "rouge2_illustration_list" then
		self._illustrationListConfig = configTable

		self:initIllustrationList()
	elseif configName == "rouge2_formula" then
		self._formulaConfig = configTable
	elseif configName == "rouge2_special_event" then
		self._specialEventConfig = configTable
	elseif configName == "rouge2_shop_date" then
		self._rewardStateConfig = configTable
	elseif configName == "rouge2_material" then
		self._materialConfig = configTable
	elseif configName == "rouge2_job_level" then
		self._jobConfig = configTable
	end
end

function Rouge2_OutSideConfig:initItemConfig()
	self._itemIdDic = {}

	for _, itemConfig in ipairs(self._itemListConfig.configList) do
		if not self._itemIdDic[itemConfig.itemId] then
			self._itemIdDic[itemConfig.itemId] = itemConfig.id
		else
			logError("造物图鉴表 道具id 重复 id: " .. itemConfig.id .. "itemId: " .. itemConfig.itemId)
		end
	end
end

function Rouge2_OutSideConfig:initRewardConfig()
	self._rewardStageListDic = {}
	self._rewardGoodsListDic = {}

	for _, config in ipairs(self._rewardConfig.configList) do
		if config.rewardScore == 0 then
			local stage = config.stage
			local stageRewardGroupDic, rewardGoodsList

			if self._rewardStageListDic[stage] == nil then
				stageRewardGroupDic = {}
				rewardGoodsList = {}
				self._rewardStageListDic[stage] = stageRewardGroupDic
				self._rewardGoodsListDic[stage] = rewardGoodsList
			else
				stageRewardGroupDic = self._rewardStageListDic[stage]
				rewardGoodsList = self._rewardGoodsListDic[stage]
			end

			stageRewardGroupDic[config.group] = stageRewardGroupDic[config.group] or {}

			table.insert(stageRewardGroupDic[config.group], config)
			table.insert(rewardGoodsList, config)
		end
	end
end

function Rouge2_OutSideConfig:getRewardConfigListByStage(stageId)
	if not stageId or not self._rewardStageListDic then
		return nil
	end

	return self._rewardStageListDic[stageId]
end

function Rouge2_OutSideConfig:getAllRewardConfigListByStage(stageId)
	if not stageId or not self._rewardGoodsListDic then
		return nil
	end

	return self._rewardGoodsListDic[stageId]
end

function Rouge2_OutSideConfig:getRewardConfigById(id)
	return self:_getPrimarykeyCo(self._rewardConfig, id)
end

function Rouge2_OutSideConfig:getRewardStageConfigById(id)
	return self:_getPrimarykeyCo(self._rewardStateConfig, id)
end

function Rouge2_OutSideConfig:getConstConfigById(id)
	return self:_getPrimarykeyCo(self._outSideConstConfig, id)
end

function Rouge2_OutSideConfig:getRewardConfigList()
	if not self._rewardConfig or not self._rewardConfig.configList then
		return nil
	end

	return self._rewardConfig.configList
end

function Rouge2_OutSideConfig:initTalentTypeConfig()
	self._talentTypeConfigDic = {}
	self._talentTypeConfigList = {}
	self._talentTypeConfigMap = {}
	self._talentTypeOrderConfigMap = {}

	local configList = self._geniusTypeConfig.configList

	for _, config in ipairs(configList) do
		local talentType = config.talent

		if not self._talentTypeConfigDic[talentType] then
			self._talentTypeConfigDic[talentType] = {}
			self._talentTypeConfigList[talentType] = {}
			self._talentTypeOrderConfigMap[talentType] = {}
		end

		self._talentTypeConfigMap[config.geniusId] = self._talentTypeConfigMap[config.geniusId] or config
		self._talentTypeOrderConfigMap[talentType][config.order] = self._talentTypeOrderConfigMap[talentType][config.order] or config
		self._talentTypeConfigDic[talentType][config.geniusId] = self._talentTypeConfigDic[talentType][config.geniusId] or config

		table.insert(self._talentTypeConfigList[talentType], config)
	end
end

function Rouge2_OutSideConfig:getTalentTypeConfigByTalentId(talentId)
	if self._talentTypeConfigMap == nil then
		return nil
	end

	return self._talentTypeConfigMap[talentId]
end

function Rouge2_OutSideConfig:getTalentConfigListByType(talentType)
	if self._talentTypeConfigList == nil then
		return nil
	end

	return self._talentTypeConfigList[talentType]
end

function Rouge2_OutSideConfig:getTalentConfigList()
	if not self._geniusConfig or not self._geniusConfig.configList then
		return nil
	end

	return self._geniusConfig.configList
end

function Rouge2_OutSideConfig:getRewardStateList()
	if not self._rewardStateConfig or not self._rewardStateConfig.configList then
		return nil
	end

	return self._rewardStateConfig.configList
end

function Rouge2_OutSideConfig:getTalentConfigById(talentId)
	return self:_getPrimarykeyCo(self._geniusConfig, talentId)
end

function Rouge2_OutSideConfig:getTalentTypeConfigById(typeId, talentId)
	return self:_get2PrimarykeyCo(self._geniusTypeConfig, typeId, talentId)
end

function Rouge2_OutSideConfig:getTalentTypeConfigByOrder(typeId, order)
	if not self._talentTypeOrderConfigMap[typeId] then
		return nil
	end

	return self._talentTypeOrderConfigMap[typeId][order]
end

function Rouge2_OutSideConfig:initStoryList()
	local list = {}

	for _, v in ipairs(self._storyListConfig.configList) do
		table.insert(list, v)
	end

	table.sort(list, Rouge2_OutSideConfig._sortStory)

	self._storyList = {}
	self._storyMap = {}

	for i, v in ipairs(list) do
		local t = {}

		t.index = i
		t.config = v
		t.storyIdList = string.splitToNumber(v.storyIdList, "#")

		table.insert(self._storyList, t)

		local storyId = t.storyIdList[#t.storyIdList]

		self._storyMap[storyId] = true
	end
end

function Rouge2_OutSideConfig:getStoryList()
	return self._storyList
end

function Rouge2_OutSideConfig:inRougeStoryList(storyId)
	return self._storyMap and self._storyMap[storyId]
end

function Rouge2_OutSideConfig._sortStory(a, b)
	if a.stageId ~= b.stageId then
		return a.stageId < b.stageId
	end

	return a.id < b.id
end

function Rouge2_OutSideConfig:initIllustrationList()
	self._illustrationList = {}
	self._illustrationPages = {}

	local list = {}

	for _, v in ipairs(self._illustrationListConfig.configList) do
		if v.type == Rouge2_OutsideEnum.IllustrationDetailType.Illustration then
			table.insert(list, v)
		end
	end

	table.sort(list, Rouge2_OutSideConfig._sortIllustration)

	local usePageIndex = 0

	for i, v in ipairs(list) do
		local page = self._illustrationPages[usePageIndex]

		if page then
			if not #page then
				local illustrationCount = 0
				local isFull = illustrationCount >= Rouge2_OutsideEnum.IllustrationNumOfPage

				if not page or isFull then
					usePageIndex = usePageIndex + 1
					self._illustrationPages[usePageIndex] = {}
				end

				local eventIdList = string.splitToNumber(v.eventId, "|")
				local mo = {
					config = v,
					eventIdList = eventIdList
				}

				table.insert(self._illustrationPages[usePageIndex], mo)
				table.insert(self._illustrationList, mo)
			end
		end
	end
end

function Rouge2_OutSideConfig._sortIllustration(a, b)
	if a.order ~= b.order then
		return a.order > b.order
	end

	return a.id < b.id
end

function Rouge2_OutSideConfig:getIllustrationList()
	return self._illustrationList
end

function Rouge2_OutSideConfig:getIllustrationPages()
	return self._illustrationPages
end

function Rouge2_OutSideConfig:getIllustrationConfig(id)
	return self:_getPrimarykeyCo(self._illustrationListConfig, id)
end

function Rouge2_OutSideConfig:getFormulaConfig(formulaId)
	return self._formulaConfig and self._formulaConfig.configDict[formulaId]
end

function Rouge2_OutSideConfig:getFormulaConfigList()
	return self._formulaConfig and self._formulaConfig.configList
end

function Rouge2_OutSideConfig:getMaterialConfig(materialId)
	return self:_getPrimarykeyCo(self._materialConfig, materialId)
end

function Rouge2_OutSideConfig:getJobConfig(jobId)
	return self:_getPrimarykeyCo(self._jobConfig, jobId)
end

function Rouge2_OutSideConfig:getJobConfigList()
	return self._jobConfig.configList
end

function Rouge2_OutSideConfig:getMaterialConfigList()
	return self._materialConfig and self._materialConfig.configList
end

function Rouge2_OutSideConfig:getItemConfigIdByItemId(itemId)
	return self._itemIdDic[itemId]
end

function Rouge2_OutSideConfig:getCollectionConfig(configId)
	return self:_getPrimarykeyCo(self._itemListConfig, configId)
end

function Rouge2_OutSideConfig:getAllInteractCollections()
	local result = {}

	self:getSingleCollectionList(lua_rouge2_relics.configList, result)
	self:getSingleCollectionList(lua_rouge2_buff.configList, result)
	self:getSingleCollectionList(lua_rouge2_active_skill.configList, result)

	return result
end

function Rouge2_OutSideConfig:getSingleCollectionList(configList, result)
	for _, config in ipairs(configList) do
		if config.isOff == 0 and config.sortId ~= nil and config.sortId ~= 0 then
			if config.isHide == 1 then
				if Rouge2_OutsideModel.instance:collectionIsPass(config.id) then
					table.insert(result, config)
				end
			else
				table.insert(result, config)
			end
		end
	end
end

function Rouge2_OutSideConfig.getItemConfig(itemId)
	local bagType = Rouge2_BackpackHelper.itemId2Tag(itemId)

	if bagType == Rouge2_OutsideEnum.CollectionListType.AutoBuff then
		return Rouge2_CollectionConfig.instance:getActiveSkillConfig(itemId)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Buff then
		return Rouge2_CollectionConfig.instance:getBuffConfig(itemId)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Collection then
		return Rouge2_CollectionConfig.instance:getRelicsConfig(itemId)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end
end

function Rouge2_OutSideConfig:_getPrimarykeyCo(configTable, key)
	if configTable and configTable.configDict then
		return configTable.configDict[key]
	end

	return nil
end

function Rouge2_OutSideConfig:_get2PrimarykeyCo(configTable, key1, key2)
	if configTable and configTable.configDict then
		local configDict = configTable.configDict[key1]

		return configDict and configDict[key2]
	end

	return nil
end

function Rouge2_OutSideConfig:_get2PrimarykeyDic(configTable, key1)
	if configTable and configTable.configDict then
		local configDict = configTable.configDict[key1]

		return configDict and configDict.configDict
	end

	return nil
end

function Rouge2_OutSideConfig:isCareerUnlock()
	return false
end

Rouge2_OutSideConfig.instance = Rouge2_OutSideConfig.New()

return Rouge2_OutSideConfig
