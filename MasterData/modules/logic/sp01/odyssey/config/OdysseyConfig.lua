-- chunkname: @modules/logic/sp01/odyssey/config/OdysseyConfig.lua

local OdysseyConfig = class("OdysseyConfig", BaseConfig)

function OdysseyConfig:ctor()
	return
end

function OdysseyConfig:reqConfigNames()
	return {
		"odyssey_const",
		"odyssey_map",
		"odyssey_element",
		"odyssey_option_element",
		"odyssey_option",
		"odyssey_dialog_element",
		"odyssey_fight_element",
		"odyssey_map_task",
		"odyssey_drop",
		"odyssey_religion",
		"odyssey_religion_clue",
		"odyssey_item",
		"odyssey_level_suppress",
		"odyssey_equip_suit",
		"odyssey_equip_suit_effect",
		"odyssey_talent",
		"odyssey_level",
		"odyssey_myth",
		"odyssey_task",
		"odyssey_fight_task_desc"
	}
end

function OdysseyConfig:onConfigLoaded(configName, configTable)
	if configName == "odyssey_const" then
		self._constConfig = configTable
	elseif configName == "odyssey_map" then
		self._mapConfig = configTable
	elseif configName == "odyssey_element" then
		self._elementConfig = configTable
		self._mapElementDict = {}
		self._mapElementList = {}

		self:buildMapElementConfig()
	elseif configName == "odyssey_option_element" then
		self._optionElementConfig = configTable
	elseif configName == "odyssey_option" then
		self._optionConfig = configTable
		self._dataBaseOptionDict = {}

		self:buildDataBaseOptionConfig()
	elseif configName == "odyssey_dialog_element" then
		self._dialogElementConfig = configTable
	elseif configName == "odyssey_fight_element" then
		self._fightElementConfig = configTable
	elseif configName == "odyssey_map_task" then
		self._mapTaskConfig = configTable
	elseif configName == "odyssey_drop" then
		self._dropConfig = configTable
	elseif configName == "odyssey_religion" then
		self._religionConfig = configTable
	elseif configName == "odyssey_religion_clue" then
		self._religionClueConfig = configTable
	elseif configName == "odyssey_item" then
		self._itemConfig = configTable
	elseif configName == "odyssey_level" then
		self._levelConfig = configTable
	elseif configName == "odyssey_level_suppress" then
		self._levelSuppressConfig = configTable
	elseif configName == "odyssey_equip_suit" then
		self._equipSuitConfig = configTable
	elseif configName == "odyssey_equip_suit_effect" then
		self._equipSuitEffectConfig = configTable
		self._suitAllEffectList = {}
	elseif configName == "odyssey_talent" then
		self._talentConfig = configTable
		self._talentAllEffectList = {}
		self._talentTypeCoList = {}
		self._talentNodePreCoList = {}

		self:buildTalentCoList()
	elseif configName == "odyssey_myth" then
		self._mythConfig = configTable
	elseif configName == "odyssey_task" then
		self._taskConfig = configTable
	elseif configName == "odyssey_fight_task_desc" then
		self._fightTaskDescConfig = configTable
	end
end

function OdysseyConfig:getConstConfig(id)
	return self._constConfig.configDict[id]
end

function OdysseyConfig:buildMapElementConfig()
	for index, elementCo in ipairs(self._elementConfig.configList) do
		local elementMap = self._mapElementDict[elementCo.mapId]

		if not elementMap then
			elementMap = {}
			self._mapElementDict[elementCo.mapId] = elementMap
			self._mapElementList[elementCo.mapId] = {}
		end

		if not elementMap[elementCo.id] then
			elementMap[elementCo.id] = elementCo

			table.insert(self._mapElementList[elementCo.mapId], elementCo)
		end
	end
end

function OdysseyConfig:getDungeonMapConfig(id)
	return self._mapConfig.configDict[id]
end

function OdysseyConfig:getAllDungeonMapCoList()
	return self._mapConfig.configList
end

function OdysseyConfig:getMapAllElementCoList(mapId)
	return self._mapElementList[mapId]
end

function OdysseyConfig:getElementConfig(elementId)
	return self._elementConfig.configDict[elementId]
end

function OdysseyConfig:getAllElementCoList()
	return self._elementConfig.configList
end

function OdysseyConfig:getMainTaskConfig(elementId)
	for _, mapTaskCo in ipairs(self._mapTaskConfig.configList) do
		local mainElementList = string.splitToNumber(mapTaskCo.elementList, "#")

		for _, taskElemenetId in ipairs(mainElementList) do
			if taskElemenetId == elementId then
				return mapTaskCo
			end
		end
	end
end

function OdysseyConfig:getMapTaskCo(mapTaskId)
	return self._mapTaskConfig.configDict[mapTaskId]
end

function OdysseyConfig:getDialogConfig(elementId, stepId)
	return self._dialogElementConfig.configDict[elementId] and self._dialogElementConfig.configDict[elementId][stepId]
end

function OdysseyConfig:buildDataBaseOptionConfig()
	for index, optionCo in ipairs(self._optionConfig.configList) do
		if optionCo.dataBase > 0 then
			self._dataBaseOptionDict[optionCo.dataBase] = optionCo
		end
	end
end

function OdysseyConfig:getOptionConfig(id)
	return self._optionConfig.configDict[id]
end

function OdysseyConfig:checkIsOptionDataBase(dataBaeId)
	return self._dataBaseOptionDict[dataBaeId]
end

function OdysseyConfig:getElementFightConfig(id)
	return self._fightElementConfig.configDict[id]
end

function OdysseyConfig:getElemenetOptionConfig(id)
	return self._optionElementConfig.configDict[id]
end

function OdysseyConfig:getItemConfig(id)
	return self._itemConfig.configDict[id]
end

function OdysseyConfig:getItemConfigList()
	return self._itemConfig.configList
end

function OdysseyConfig:getEquipSuitConfig(id)
	return self._equipSuitConfig.configDict[id]
end

function OdysseyConfig:getEquipSuitConfigList()
	return self._equipSuitConfig.configList
end

function OdysseyConfig:getLevelSuppressConfig(levelDifference)
	for index, config in ipairs(self._levelSuppressConfig.configList) do
		if config.levelDifference == levelDifference then
			return config
		end
	end
end

function OdysseyConfig:getLevelConfig(level)
	return self._levelConfig.configDict[level]
end

function OdysseyConfig:getLevelConfigList()
	return self._levelConfig.configList
end

function OdysseyConfig:getEquipDropConfig(dropId)
	return self._dropConfig.configDict[dropId]
end

function OdysseyConfig:getEquipSuitAllEffect(suitId)
	local allEffectList = self._suitAllEffectList[suitId]

	if not allEffectList then
		if not self._equipSuitEffectConfig.configDict[suitId] then
			return nil
		end

		allEffectList = tabletool.copy(self._equipSuitEffectConfig.configDict[suitId])

		table.sort(allEffectList, function(a, b)
			return a.level < b.level
		end)

		self._suitAllEffectList[suitId] = allEffectList
	end

	return allEffectList
end

function OdysseyConfig:getEquipSuitEffectConfig(suitId, level)
	return self._equipSuitEffectConfig.configDict[suitId] and self._equipSuitEffectConfig.configDict[suitId][level]
end

function OdysseyConfig:getTalentConfig(nodeId, level)
	return self._talentConfig.configDict[nodeId] and self._talentConfig.configDict[nodeId][level]
end

function OdysseyConfig:buildTalentCoList()
	for index, config in ipairs(self._talentConfig.configList) do
		local allTalentList = self._talentAllEffectList[config.nodeId]

		if not allTalentList then
			allTalentList = tabletool.copy(self._talentConfig.configDict[config.nodeId])

			table.sort(allTalentList, function(a, b)
				return a.level < b.level
			end)

			self._talentAllEffectList[config.nodeId] = allTalentList
			self._talentTypeCoList[config.type] = self._talentTypeCoList[config.type] or {}

			table.insert(self._talentTypeCoList[config.type], config)
		end
	end

	for type, talentTypeList in pairs(self._talentTypeCoList) do
		table.sort(talentTypeList, function(a, b)
			return a.nodeId < b.nodeId
		end)
	end
end

function OdysseyConfig:getAllTalentEffectConfigByNodeId(nodeId)
	return self._talentAllEffectList[nodeId]
end

function OdysseyConfig:getAllTalentConfigByType(talentType)
	return self._talentTypeCoList[talentType]
end

function OdysseyConfig:getTalentParentNodeConfig(nodeId)
	local preNodeCo = self._talentNodePreCoList[nodeId]

	if not preNodeCo then
		local effectCoList = self:getAllTalentEffectConfigByNodeId(nodeId)
		local unlockConditionStr = effectCoList[1].unlockCondition

		if string.nilorempty(unlockConditionStr) then
			return nil
		end

		local unlockConditionList = GameUtil.splitString2(unlockConditionStr)

		for _, unlockConditionData in ipairs(unlockConditionList) do
			if unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
				local preNodeId = tonumber(unlockConditionData[2])

				preNodeCo = self:getTalentConfig(preNodeId, 1)

				break
			end
		end

		self._talentNodePreCoList[nodeId] = preNodeCo
	end

	return preNodeCo
end

function OdysseyConfig:getFightElementCoListByType(fightType)
	local elementCoList = {}

	for index, config in ipairs(self._fightElementConfig.configList) do
		if config.type == fightType then
			table.insert(elementCoList, config)
		end
	end

	return elementCoList
end

function OdysseyConfig:getMythConfig(id)
	return self._mythConfig.configDict[id]
end

function OdysseyConfig:getMythConfigList()
	return self._mythConfig.configList
end

function OdysseyConfig:getReligionConfig(id)
	return self._religionConfig.configDict[id]
end

function OdysseyConfig:getReligionConfigList()
	return self._religionConfig.configList
end

function OdysseyConfig:getReligionClueConfig(id)
	return self._religionClueConfig.configDict[id]
end

function OdysseyConfig:getTaskConfig(id)
	return self._taskConfig.configDict[id]
end

function OdysseyConfig:getBigRewardTaskConfig()
	for index, taskConfig in ipairs(self._taskConfig.configList) do
		if taskConfig.isKeyReward == 1 then
			return taskConfig
		end
	end
end

function OdysseyConfig:getFightTaskDescConfig(id)
	return self._fightTaskDescConfig.configDict[id]
end

function OdysseyConfig:getMythConfigByElementId(elementId)
	for index, co in ipairs(self._mythConfig.configList) do
		if co.elementId == elementId then
			return co
		end
	end
end

OdysseyConfig.instance = OdysseyConfig.New()

return OdysseyConfig
