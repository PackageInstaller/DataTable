-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryConfig.lua

module("modules.logic.necrologiststory.config.NecrologistStoryConfig", package.seeall)

local NecrologistStoryConfig = class("NecrologistStoryConfig", BaseConfig)

function NecrologistStoryConfig:ctor()
	self._openConfig = nil
	self._opengroupConfig = nil
	self.versionConfigList = {
		NecrologistStoryV3A1Config,
		NecrologistStoryV3A2Config,
		NecrologistStoryV3A4Config,
		NecrologistStoryV3A5Config,
		NecrologistStoryV3A7Config,
		NecrologistStoryV3A9Config
	}
end

function NecrologistStoryConfig:reqConfigNames()
	local list = {
		"hero_story_plot",
		"hero_story_plot_group",
		"hero_story_introduce",
		"hero_story_task",
		"hero_story_ending"
	}

	self.configNameLoadedDict = {}

	for index, configClass in ipairs(self.versionConfigList) do
		local configNames = configClass.instance:reqConfigNames()

		for _, configName in ipairs(configNames) do
			table.insert(list, configName)

			self.configNameLoadedDict[configName] = index
		end
	end

	return list
end

function NecrologistStoryConfig:onConfigLoaded(configName, configTable)
	local classIndex = self.configNameLoadedDict[configName]

	if classIndex then
		local configClass = self.versionConfigList[classIndex]

		if configClass then
			configClass.instance:onConfigLoaded(configName, configTable)
		end

		return
	end

	local loadFuncName = string.format("on%sLoaded", configName)
	local func = self[loadFuncName]

	if func then
		func(self, configTable)
	end
end

function NecrologistStoryConfig:onhero_story_endingLoaded(configTable)
	self._heroStoryEndingConfig = configTable

	self:initEndingDict()
end

function NecrologistStoryConfig:onhero_story_plot_groupLoaded(configTable)
	self._heroStoryPlotGroupConfig = configTable
end

function NecrologistStoryConfig:onhero_story_taskLoaded(configTable)
	self._heroStoryTaskConfig = configTable
end

function NecrologistStoryConfig:onhero_story_plotLoaded(configTable)
	self._heroStoryMainConfig = configTable
end

function NecrologistStoryConfig:getOptionListByStoryId(storyId)
	self:_initGroupList()

	local plotList = self:getPlotListByStoryId(storyId)
	local list = {}

	for _, plot in ipairs(plotList) do
		local data = self._heroStroyPlotGroupOptionDict[plot.id]

		if data then
			table.insert(list, data)
		else
			table.insert(list, {
				storygroup = plot.id
			})
		end
	end

	return list
end

function NecrologistStoryConfig:_formatPlotOptionData(config, dataDict)
	local data = dataDict[config.storygroup]

	if not data then
		data = {
			storygroup = config.storygroup,
			optionList = {},
			affectsEndingOptionIndexs = {}
		}
		data.optionIndex = 0
		data.endingList = {}
		dataDict[config.storygroup] = data
	end

	local list = data.optionList

	if string.find(config.type, "options") then
		local sections = GameUtil.splitString2(config.param, true, "#", ",")
		local optionList = {}

		table.insert(list, optionList)

		for i, v in ipairs(sections) do
			data.optionIndex = data.optionIndex + 1

			local optionData = {}

			optionData.id = data.optionIndex
			optionData.config = config
			optionData.index = i

			table.insert(optionList, optionData)
		end
	elseif config.type == "situationValue" then
		local optionList = data.optionList[#data.optionList]

		if optionList then
			for i, v in ipairs(optionList) do
				data.affectsEndingOptionIndexs[v.id] = true
			end
		end
	end

	local endingCo = self:getEndingCoByStep(config.id)

	if endingCo then
		local endingData = {}

		endingData.id = endingCo.id
		endingData.isEnding = true
		endingData.config = config
		endingData.endingCo = endingCo

		table.insert(data.endingList, endingData)
	end
end

function NecrologistStoryConfig:_initGroupList()
	if self._heroStoryMainDict then
		return
	end

	self._heroStoryMainDict = {}
	self._heroStroyPlotGroupOptionDict = {}

	local sectionId
	local defaultId = 0
	local configTable = self._heroStoryMainConfig
	local selectKeys = {
		selector = 1
	}
	local selectEndKeys = {
		selectorend = 1
	}

	for _, co in ipairs(configTable.configList) do
		local group = self._heroStoryMainDict[co.storygroup]

		if not group then
			group = {}
			self._heroStoryMainDict[co.storygroup] = group
			sectionId = defaultId
		end

		if selectKeys[co.type] then
			sectionId = tonumber(co.param)
		elseif selectEndKeys[co.type] then
			sectionId = defaultId
		else
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], co)
		end

		self:_formatPlotOptionData(co, self._heroStroyPlotGroupOptionDict)
	end

	for _, group in pairs(self._heroStoryMainDict) do
		for _, coList in pairs(group) do
			table.sort(coList, SortUtil.keyLower("id"))
		end
	end
end

function NecrologistStoryConfig:getOptionIdByConfigAndIndex(config, index)
	if not config then
		return nil
	end

	self:_initGroupList()

	local data = self._heroStroyPlotGroupOptionDict[config.storygroup]

	if not data then
		return nil
	end

	local optionList = data.optionList

	if not optionList then
		return nil
	end

	local optionIds, curId

	for _, options in ipairs(optionList) do
		for _, optionData in ipairs(options) do
			if optionData.index == index and optionData.config.id == config.id then
				curId = optionData.id
				optionIds = {}

				for _, v in ipairs(options) do
					optionIds[v.id] = true
				end

				break
			end
		end
	end

	return curId, optionIds
end

function NecrologistStoryConfig:onhero_story_introduceLoaded(configTable)
	self._heroStoryIntroduceConfig = configTable
end

function NecrologistStoryConfig:getStoryListByGroupId(groupId)
	self:_initGroupList()

	local storyGroup = self._heroStoryMainDict[groupId]

	if not storyGroup then
		logError(string.format("storygroup config list is nil, groupId:%s", groupId))
	end

	return storyGroup
end

function NecrologistStoryConfig:getStoryConfig(storyId, notError)
	local co = self._heroStoryMainConfig.configDict[storyId]

	if not co and not notError then
		logError(string.format("story config is nil, storyId:%s", storyId))
	end

	return co
end

function NecrologistStoryConfig:getIntroduceCoByName(name)
	if not self.introduceCoByName then
		self.introduceCoByName = {}

		for i, v in ipairs(self._heroStoryIntroduceConfig.configList) do
			self.introduceCoByName[v.name] = v
		end
	end

	local co = self.introduceCoByName[name]

	if not co then
		logError(string.format("名词说明 '%s' 不存在!!!", tostring(name)))
	end

	return co
end

function NecrologistStoryConfig:getIntroduceCo(id)
	if id == nil then
		return
	end

	local co = self._heroStoryIntroduceConfig.configDict[id]

	if not co then
		logError(string.format("IntroduceConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getTaskCo(id)
	local co = self._heroStoryTaskConfig.configDict[id]

	if not co then
		logError(string.format("TaskConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getPlotGroupCo(id)
	local co = self._heroStoryPlotGroupConfig.configDict[id]

	if not co then
		logError(string.format("PlotGroupConfig is nil id:%s", id))
	end

	return co
end

function NecrologistStoryConfig:getPlotListByStoryId(storyId)
	if not self._plotListByStoryIdDict then
		self._plotListByStoryIdDict = {}

		for _, co in ipairs(self._heroStoryPlotGroupConfig.configList) do
			self._plotListByStoryIdDict[co.storyId] = self._plotListByStoryIdDict[co.storyId] or {}

			table.insert(self._plotListByStoryIdDict[co.storyId], co)
		end
	end

	return self._plotListByStoryIdDict[storyId] or {}
end

function NecrologistStoryConfig:initEndingDict()
	self._endingDict = {}
	self._heroStory2EndingDict = {}

	for _, co in ipairs(self._heroStoryEndingConfig.configList) do
		self._endingDict[co.storyStep] = co
		self._heroStory2EndingDict[co.storyId] = self._heroStory2EndingDict[co.storyId] or {}

		table.insert(self._heroStory2EndingDict[co.storyId], co)
	end
end

function NecrologistStoryConfig:getEndingCo(id)
	return self._heroStoryEndingConfig.configDict[id]
end

function NecrologistStoryConfig:getEndingCoByStep(step)
	return self._endingDict[step]
end

function NecrologistStoryConfig:getEndingListByStoryId(storyId)
	return self._heroStory2EndingDict[storyId]
end

NecrologistStoryConfig.instance = NecrologistStoryConfig.New()

return NecrologistStoryConfig
