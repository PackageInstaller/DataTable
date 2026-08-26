-- chunkname: @modules/logic/versionactivity1_5/aizila/config/AiZiLaConfig.lua

module("modules.logic.versionactivity1_5.aizila.config.AiZiLaConfig", package.seeall)

local AiZiLaConfig = class("AiZiLaConfig", BaseConfig)

function AiZiLaConfig:ctor()
	self._actMap = nil
	self._episodeConfig = nil
	self._episodeListDict = {}
	self._storyConfig = nil
	self._storyListDict = {}
end

function AiZiLaConfig:reqConfigNames()
	return {
		"activity144_episode",
		"activity144_story",
		"activity144_task",
		"activity144_equip",
		"activity144_round",
		"activity144_event",
		"activity144_item",
		"activity144_episode_showtarget",
		"activity144_option",
		"activity144_option_result",
		"activity144_record_event",
		"activity144_buff"
	}
end

function AiZiLaConfig:onConfigLoaded(configName, configTable)
	if configName == "activity144_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity144_story" then
		self._storyConfig = configTable
	elseif configName == "activity144_task" then
		self._taskConfig = configTable
	elseif configName == "activity144_equip" then
		self._equipConfig = configTable

		self:_initEquipCfg()
	elseif configName == "activity144_round" then
		self._roundConfig = configTable
	elseif configName == "activity144_event" then
		self._eventConfig = configTable
	elseif configName == "activity144_item" then
		self._itemConfig = configTable
	elseif configName == "activity144_episode_showtarget" then
		self._eqisodeShowTargetConfig = configTable
	elseif configName == "activity144_option" then
		self._optionConfig = configTable
	elseif configName == "activity144_option_result" then
		self._optionResultConfig = configTable
	elseif configName == "activity144_buff" then
		self._buffConfig = configTable
	elseif configName == "activity144_record_event" then
		self._recordEventConfig = configTable
	end
end

function AiZiLaConfig:_get2PrimarykeyCo(configTable, key1, key2)
	if configTable and configTable.configDict then
		local configDict = configTable.configDict[key1]

		return configDict and configDict[key2]
	end

	return nil
end

function AiZiLaConfig:_findListByActId(configTable, actId)
	if configTable and configTable.configList then
		local list = {}

		for _, co in ipairs(configTable.configList) do
			if co.activityId == actId then
				table.insert(list, co)
			end
		end

		return list
	end

	return nil
end

function AiZiLaConfig:getTaskList(actId)
	return self:_findListByActId(self._taskConfig, actId)
end

function AiZiLaConfig:getItemList()
	return self._itemConfig and self._itemConfig.configList
end

function AiZiLaConfig:_initEquipCfg()
	self._equipUpLevelDict = {}
	self._equipTypeListDict = {}

	for _, co in ipairs(self._equipConfig.configList) do
		if co.preEquipId == 0 then
			local actId = co.activityId

			self._equipTypeListDict[actId] = self._equipTypeListDict[actId] or {}

			table.insert(self._equipTypeListDict[actId], co)
		end
	end
end

function AiZiLaConfig:getEquipCo(actId, equipId)
	return self:_get2PrimarykeyCo(self._equipConfig, actId, equipId)
end

function AiZiLaConfig:getEquipCoByPreId(actId, preEquipId, typeId)
	for _, co in ipairs(self._equipConfig.configList) do
		if co.activityId == actId and co.preEquipId == preEquipId and (typeId == nil or typeId == co.typeId) then
			return co
		end
	end
end

function AiZiLaConfig:getEquipCoTypeList(actId)
	return self._equipTypeListDict and self._equipTypeListDict[actId]
end

function AiZiLaConfig:getItemCo(itemId)
	return self._itemConfig and self._itemConfig.configDict[itemId]
end

function AiZiLaConfig:getEpisodeShowTargetCo(id)
	return self._eqisodeShowTargetConfig and self._eqisodeShowTargetConfig.configDict[id]
end

function AiZiLaConfig:getEpisodeCo(actId, episodeId)
	return self:_get2PrimarykeyCo(self._episodeConfig, actId, episodeId)
end

function AiZiLaConfig:getRoundCo(actId, episodeId, round)
	local cfgList = self._roundConfig.configList

	for _, cfg in ipairs(cfgList) do
		if cfg.activityId == actId and cfg.episodeId == episodeId and cfg.round == round then
			return cfg
		end
	end
end

function AiZiLaConfig:getPassRoundCo(actId, episodeId)
	local cfgList = self._roundConfig.configList
	local minCfg

	for _, cfg in ipairs(cfgList) do
		if cfg.activityId == actId and cfg.episodeId == episodeId and cfg.isPass == 1 and (not minCfg or minCfg.round < cfg.round) then
			minCfg = cfg
		end
	end

	return minCfg
end

function AiZiLaConfig:getRoundList(actId, episodeId)
	local cfgList = self._roundConfig.configList
	local list = {}

	for _, cfg in ipairs(cfgList) do
		if cfg.activityId == actId and cfg.episodeId == episodeId then
			table.insert(list, cfg)
		end
	end

	return list
end

function AiZiLaConfig:getBuffCo(actId, buffId)
	if not self._buffConfig then
		logError("AiZiLaConfig:getBuffCo(actId, buffId)")
	end

	return self:_get2PrimarykeyCo(self._buffConfig, actId, buffId)
end

function AiZiLaConfig:getRecordEventCo(actId, recordId)
	return self:_get2PrimarykeyCo(self._recordEventConfig, actId, recordId)
end

function AiZiLaConfig:getRecordEventList(actId)
	return self:_findListByActId(self._recordEventConfig, actId)
end

function AiZiLaConfig:getEventCo(actId, eventId)
	return self:_get2PrimarykeyCo(self._eventConfig, actId, eventId)
end

function AiZiLaConfig:getOptionCo(actId, optionId)
	return self:_get2PrimarykeyCo(self._optionConfig, actId, optionId)
end

function AiZiLaConfig:getOptionResultCo(actId, optionId)
	return self:_get2PrimarykeyCo(self._optionResultConfig, actId, optionId)
end

function AiZiLaConfig:getEpisodeList(actId)
	if self._episodeListDict[actId] then
		return self._episodeListDict[actId]
	end

	local episodeList = {}

	self._episodeListDict[actId] = episodeList

	if self._episodeConfig and self._episodeConfig.configDict[actId] then
		for k, v in pairs(self._episodeConfig.configDict[actId]) do
			table.insert(episodeList, v)
		end

		table.sort(episodeList, AiZiLaConfig.sortEpisode)
	end

	return episodeList
end

function AiZiLaConfig.sortEpisode(item1, item2)
	if item1.episodeId ~= item2.episodeId then
		return item1.episodeId < item2.episodeId
	end
end

function AiZiLaConfig:getStoryList(actId)
	if self._storyListDict[actId] then
		return self._storyListDict[actId]
	end

	local storyList = {}

	self._storyListDict[actId] = storyList

	if self._storyConfig and self._storyConfig.configDict[actId] then
		for k, v in pairs(self._storyConfig.configDict[actId]) do
			table.insert(storyList, v)
		end

		table.sort(storyList, AiZiLaConfig.sortStory)
	end

	return storyList
end

function AiZiLaConfig.sortStory(item1, item2)
	if item1.order ~= item2.order then
		return item1.order < item2.order
	end
end

AiZiLaConfig.instance = AiZiLaConfig.New()

return AiZiLaConfig
