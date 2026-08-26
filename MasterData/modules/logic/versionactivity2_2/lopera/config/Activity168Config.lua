-- chunkname: @modules/logic/versionactivity2_2/lopera/config/Activity168Config.lua

module("modules.logic.versionactivity2_2.lopera.config.Activity168Config", package.seeall)

local Activity168Config = class("Activity168Config", BaseConfig)

function Activity168Config:onInit()
	self._episodeConfig = nil
	self._eventConfig = nil
	self._optionConfig = nil
	self._effectConfig = nil
	self._itemConfig = nil
	self._taskCfg = nil
	self._composeTypeCfg = nil
	self._composeItemCfg = nil
	self._constCfg = nil
	self._endlessCfg = nil
	self._episodeDict = {}
	self._mapCfgField = {
		id = 1,
		name = 3,
		coord = 2,
		isStart = 6,
		dir = 4,
		event = 5,
		isEnd = 7
	}
end

function Activity168Config:reqConfigNames()
	return {
		"activity168_episode",
		"activity168_event",
		"activity168_option",
		"activity168_effect",
		"activity168_item",
		"activity168_compose_type",
		"activity168_task",
		"activity168_const",
		"activity168_endless_event"
	}
end

function Activity168Config:onConfigLoaded(configName, configTable)
	if configName == "activity168_episode" then
		self._episodeConfig = configTable
		self._episodeDict = {}

		for _, v in ipairs(self._episodeConfig.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	elseif configName == "activity168_event" then
		self._eventConfig = configTable
	elseif configName == "activity168_option" then
		self._optionConfig = configTable
	elseif configName == "activity168_effect" then
		self._effectConfig = configTable
	elseif configName == "activity168_item" then
		self._itemConfig = configTable
	elseif configName == "activity168_task" then
		self._taskCfg = configTable
	elseif configName == "activity168_compose_type" then
		self._composeTypeCfg = configTable
	elseif configName == "activity168_const" then
		self._constCfg = configTable
	elseif configName == "activity168_endless_event" then
		self._endlessCfg = configTable
	end
end

function Activity168Config:getEpisodeCfgList(activityId)
	return self._episodeDict[activityId] or {}
end

function Activity168Config:getEpisodeCfg(activityId, episodeId)
	local activityEpisodeList = self._episodeDict[activityId]

	for _, episoCfg in ipairs(activityEpisodeList) do
		if episoCfg.id == episodeId then
			return episoCfg
		end
	end
end

function Activity168Config:getEventCfg(activityId, eventId)
	local actEvents = self._eventConfig.configDict[activityId]

	return actEvents and actEvents[eventId]
end

function Activity168Config:getEventOptionCfg(activityId, optionId)
	local actOptions = self._optionConfig.configDict[activityId]

	return actOptions and actOptions[optionId]
end

function Activity168Config:getOptionEffectCfg(effectId)
	return self._effectConfig.configDict[effectId]
end

function Activity168Config:getGameItemCfg(activityId, itemId)
	local activityItems = self._itemConfig.configDict[activityId]

	for _, itemCfg in pairs(activityItems) do
		if itemCfg.itemId == itemId then
			return itemCfg
		end
	end
end

function Activity168Config:getGameItemListCfg(activityId, _type)
	local result = {}
	local activityItemList = self._itemConfig.configDict[activityId]

	for _, itemCfg in pairs(activityItemList) do
		if _type == nil or itemCfg.compostType == _type then
			result[#result + 1] = itemCfg
		end
	end

	return result
end

function Activity168Config:InitMapCfg(mapId)
	self._mapId = mapId
	self._mapCfg = addGlobalModule("modules.configs.act168.lua_act168_map_" .. tostring(mapId), "lua_act168_map_" .. tostring(mapId))
	self._mapRowNum = 0
	self._mapCalNum = 0

	for id, mapCell in ipairs(self._mapCfg) do
		local coord = mapCell[self._mapCfgField.coord]

		self._mapRowNum = math.max(self._mapRowNum, coord[2])
		self._mapCalNum = math.max(self._mapCalNum, coord[1])
	end

	self._mapRowNum = self._mapRowNum + 1
	self._mapCalNum = self._mapCalNum + 1
end

function Activity168Config:getMapCfg(mapId)
	if not self._mapCfg or self._mapId ~= mapId then
		self:InitMapCfg(mapId)
	end

	return self._mapCfg
end

function Activity168Config:getMapStartCell()
	for _, cellData in ipairs(self._mapCfg) do
		if cellData[self._mapCfgField.isStart] then
			return cellData
		end
	end
end

function Activity168Config:getMapEndCell()
	for _, cellData in ipairs(self._mapCfg) do
		if cellData[self._mapCfgField.isEnd] then
			return cellData
		end
	end
end

function Activity168Config:getMapCell(id)
	for _, cellData in ipairs(self._mapCfg) do
		if cellData[self._mapCfgField.id] == id then
			return cellData
		end
	end
end

function Activity168Config:getMapCellByCoord(coord)
	local idx = coord[1] + self._mapCalNum * coord[2] + 1

	return self._mapCfg[idx]
end

function Activity168Config:getTaskList(activityId)
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(self._taskCfg.configDict) do
		if activityId == v.activityId then
			self._task_list[#self._task_list + 1] = v
		end
	end

	return self._task_list
end

function Activity168Config:getComposeTypeList(activityId)
	local composeTypeList = {}

	for k, v in ipairs(self._composeTypeCfg.configList) do
		if activityId == v.activityId then
			composeTypeList[#composeTypeList + 1] = v
		end
	end

	return composeTypeList
end

function Activity168Config:getComposeTypeCfg(activityId, typeId)
	for k, v in ipairs(self._composeTypeCfg.configList) do
		if activityId == v.activityId and typeId == v.composeType then
			return v
		end
	end
end

function Activity168Config:getConstCfg(activityId, subId)
	local activityConstCfgList = self._constCfg.configDict[activityId]

	if not activityConstCfgList then
		return
	end

	for k, v in pairs(activityConstCfgList) do
		if subId == v.id then
			return v
		end
	end
end

function Activity168Config:getConstValueCfg(activityId, value1)
	local activityConstCfgList = self._constCfg.configDict[activityId]

	if not activityConstCfgList then
		return
	end

	for k, v in ipairs(activityConstCfgList) do
		if value1 == v.value1 then
			return v
		end
	end
end

function Activity168Config:getEndlessLevelCfg(activityId, endlessId)
	local cfgList = self._endlessCfg.configDict[activityId]

	if not cfgList then
		return
	end

	for k, v in ipairs(cfgList) do
		if endlessId == v.id then
			return v
		end
	end
end

Activity168Config.instance = Activity168Config.New()

return Activity168Config
