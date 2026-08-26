-- chunkname: @modules/logic/sp02/dungeonmap/config/AtomicDungeonConfig.lua

local AtomicDungeonConfig = class("AtomicDungeonConfig", BaseConfig)

function AtomicDungeonConfig:ctor()
	return
end

function AtomicDungeonConfig:reqConfigNames()
	return {
		"atomic_game_line",
		"atomic_game_color",
		"atomic_game_rhythm",
		"atomic_map",
		"atomic_element",
		"atomic_option_element",
		"atomic_option",
		"atomic_fight_element",
		"atomic_polygon_enter",
		"atomic_polygon",
		"atomic_polygon_difficulty",
		"atomic_task",
		"atomic_arena",
		"atomic_map_info",
		"atomic_key_element",
		"atomic_door_element",
		"atomic_drag_element_toast"
	}
end

function AtomicDungeonConfig:onConfigLoaded(configName, configTable)
	if configName == "atomic_game_line" then
		self._lineGameConfig = configTable
	elseif configName == "atomic_game_color" then
		self._colorGameConfig = configTable
	elseif configName == "atomic_game_rhythm" then
		self._rhythmGameConfig = configTable
	elseif configName == "atomic_map" then
		self._dungeonMapConfig = configTable
		self._allArenaMapList = {}

		self:buildAllArenaMapCoList()
	elseif configName == "atomic_element" then
		self._elementConfig = configTable
		self._mapElementDict = {}
		self._mapElementList = {}

		self:buildMapElementConfig()
	elseif configName == "atomic_option_element" then
		self._optionElementConfig = configTable
	elseif configName == "atomic_option" then
		self._optionConfig = configTable
	elseif configName == "atomic_fight_element" then
		self._fightElementConfig = configTable

		self:buildHardFightElementConfig()
	elseif configName == "atomic_polygon_enter" then
		self._polygonEnterConfig = configTable
	elseif configName == "atomic_polygon" then
		self._polygonConfig = configTable
	elseif configName == "atomic_polygon_difficulty" then
		self._polygonDifficultyConfig = configTable

		self:buildAllPolygonDiffCoList()
	elseif configName == "atomic_task" then
		self._taskConfig = configTable
	elseif configName == "atomic_arena" then
		self._arenaConfig = configTable

		self:buildArenaUnlockSeqList()
	elseif configName == "atomic_map_info" then
		self._allDungeonMapInfoCoList = {}
		self._dungeonMapInfoConfig = configTable
	elseif configName == "atomic_key_element" then
		self._keyElementConfig = configTable

		self:buildMapKeyElementConfigList()
	elseif configName == "atomic_door_element" then
		self._doorElementConfig = configTable
	elseif configName == "atomic_drag_element_toast" then
		self._dragElementToastConfig = configTable

		self:buildDragElementToastMap()
	end
end

function AtomicDungeonConfig:buildAllArenaMapCoList()
	for index, mapConfig in ipairs(self._dungeonMapConfig.configList) do
		self._allArenaMapList[mapConfig.infoId] = self._allArenaMapList[mapConfig.infoId] or {}

		table.insert(self._allArenaMapList[mapConfig.infoId], mapConfig)
	end

	for infoId, mapCoList in pairs(self._allArenaMapList) do
		table.sort(mapCoList, function(a, b)
			return a.id < b.id
		end)
	end
end

function AtomicDungeonConfig:buildMapElementConfig()
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

function AtomicDungeonConfig:getMapAllElementCoList(mapId)
	return self._mapElementList[mapId]
end

function AtomicDungeonConfig:getElementConfig(elementId)
	return self._elementConfig.configDict[elementId]
end

function AtomicDungeonConfig:getAllElementCoList()
	return self._elementConfig.configList
end

function AtomicDungeonConfig:getLineGameConfig(id)
	return self._lineGameConfig.configDict[id]
end

function AtomicDungeonConfig:getColorGameConfig(id)
	return self._colorGameConfig.configDict[id]
end

function AtomicDungeonConfig:getRhythmGameConfig(id)
	return self._rhythmGameConfig.configDict[id]
end

function AtomicDungeonConfig:getDungeonMapConfig(id)
	return self._dungeonMapConfig.configDict[id]
end

function AtomicDungeonConfig:getArenaAllDungeonMapCoList(infoId)
	return self._allArenaMapList[infoId]
end

function AtomicDungeonConfig:getOptionElementConfig(elementId, stepId)
	return self._optionElementConfig.configDict[elementId] and self._optionElementConfig.configDict[elementId][stepId]
end

function AtomicDungeonConfig:getOptionConfig(optionId)
	return self._optionConfig.configDict[optionId]
end

function AtomicDungeonConfig:getFightElementConfig(elementId)
	return self._fightElementConfig.configDict[elementId]
end

function AtomicDungeonConfig:getFightElementCoList()
	return self._fightElementConfig.configList
end

function AtomicDungeonConfig:buildHardFightElementConfig()
	self.hardFightEpisodeIdList = {}

	for _, config in ipairs(self._fightElementConfig.configList) do
		if config.type == 2 then
			local hardEpisodeIdList = string.splitToNumber(config.randomEpisodeIds, "#")

			tabletool.addValues(self.hardFightEpisodeIdList, hardEpisodeIdList)
		end
	end
end

function AtomicDungeonConfig:getHardFightEpisodeIdList()
	return self.hardFightEpisodeIdList
end

function AtomicDungeonConfig:getPolygonEnterConfig(mapId)
	return self._polygonEnterConfig.configDict[mapId]
end

function AtomicDungeonConfig:getArenaMapIdByPolygonMapId(polygonMapId)
	local polygonConfig = self:getPolygonConfig(polygonMapId)

	return polygonConfig.mapId
end

function AtomicDungeonConfig:getPolygonConfig(polygonId)
	return self._polygonConfig.configDict[polygonId]
end

function AtomicDungeonConfig:getAllPolygonCoList()
	return self._polygonConfig.configList
end

function AtomicDungeonConfig:getPolygonIdByArenaMapId(mapId)
	for _, config in ipairs(self._polygonConfig.configList) do
		if config.mapId == mapId then
			return config.id
		end
	end
end

function AtomicDungeonConfig:getDungeonMapId(mapId)
	local mapConfig = self:getDungeonMapConfig(mapId)

	return mapConfig.arenaId
end

function AtomicDungeonConfig:buildAllPolygonDiffCoList()
	self._allDiffCoList = {}

	for _, config in ipairs(self._polygonDifficultyConfig.configList) do
		self._allDiffCoList[config.id] = self._allDiffCoList[config.id] or {}

		table.insert(self._allDiffCoList[config.id], config)
	end

	for _, coList in pairs(self._allDiffCoList) do
		table.sort(coList, function(a, b)
			return a.difficulty < b.difficulty
		end)
	end

	return self._allDiffCoList
end

function AtomicDungeonConfig:getAllPolygonDiffCoList(polygonId)
	return self._allDiffCoList[polygonId]
end

function AtomicDungeonConfig:getPolygonDiffConfig(polygonId, difficulty)
	return self._polygonDifficultyConfig.configDict[polygonId] and self._polygonDifficultyConfig.configDict[polygonId][difficulty]
end

function AtomicDungeonConfig:checkIsPolygonEpisode(episodeId)
	for _, config in ipairs(self._polygonDifficultyConfig.configList) do
		if config.episodeId == episodeId then
			return true, config
		end
	end

	return false
end

function AtomicDungeonConfig:getTaskConfig(id)
	return self._taskConfig.configDict[id]
end

function AtomicDungeonConfig:getTaskConfigList()
	return self._taskConfig.configList
end

function AtomicDungeonConfig:getMapInfoConfig(infoId)
	return self._dungeonMapInfoConfig.configDict[infoId]
end

function AtomicDungeonConfig:getAllDungeonMapInfoCoList()
	if not next(self._allDungeonMapInfoCoList) then
		for index, config in ipairs(self._dungeonMapInfoConfig.configList) do
			if config.type == AtomicDungeonEnum.MapType.Normal then
				table.insert(self._allDungeonMapInfoCoList, config)
			end
		end
	end

	return self._allDungeonMapInfoCoList
end

function AtomicDungeonConfig:getArenaConfig(arenaId)
	return self._arenaConfig.configDict[arenaId]
end

function AtomicDungeonConfig:getAllArenaConfigList()
	return self._arenaConfig.configList
end

function AtomicDungeonConfig:buildArenaUnlockSeqList()
	self.arenaUnlockSeqList = {}

	for _, config in ipairs(self._arenaConfig.configList) do
		self.arenaUnlockSeqList[config.arenaId] = string.splitToNumber(config.unlockSeq, "#")
	end
end

function AtomicDungeonConfig:getArenaUnlockSeqList(arenaId)
	return self.arenaUnlockSeqList[arenaId]
end

function AtomicDungeonConfig:getMapUnlockCondition(mapInfoId)
	local arenaMapCoList = self:getArenaAllDungeonMapCoList(mapInfoId)

	return arenaMapCoList[1].unlockCondition
end

function AtomicDungeonConfig:getKeyElementConfig(keyId)
	return self._keyElementConfig.configDict[keyId]
end

function AtomicDungeonConfig:getAllKeyElementCoList()
	return self._keyElementConfig.configList
end

function AtomicDungeonConfig:buildMapKeyElementConfigList()
	self.mapKeyElementCoList = {}

	for _, config in ipairs(self._keyElementConfig.configList) do
		self.mapKeyElementCoList[config.mapId] = self.mapKeyElementCoList[config.mapId] or {}

		table.insert(self.mapKeyElementCoList[config.mapId], config)
	end
end

function AtomicDungeonConfig:getMapKeyElementConfigList(mapId)
	return self.mapKeyElementCoList[mapId] or {}
end

function AtomicDungeonConfig:getDoorElementConfig(doorId)
	return self._doorElementConfig.configDict[doorId]
end

function AtomicDungeonConfig:buildDragElementToastMap()
	self.dragElementToastMap = {}

	for _, config in ipairs(self._dragElementToastConfig.configList) do
		self.dragElementToastMap[config.id] = self.dragElementToastMap[config.id] or {}
		self.dragElementToastMap[config.id][config.targetId] = config
	end
end

function AtomicDungeonConfig:getDragElementToastConfig(keyElementId, targetElementId)
	return self.dragElementToastMap[keyElementId] and self.dragElementToastMap[keyElementId][targetElementId]
end

function AtomicDungeonConfig:checkElementIsKey(elementCo)
	return elementCo.type == AtomicDungeonEnum.ElementType.KeyDoor and not string.nilorempty(elementCo.parm) and tonumber(elementCo.parm) == AtomicDungeonEnum.PolygonKeyDoorType.Key
end

AtomicDungeonConfig.instance = AtomicDungeonConfig.New()

return AtomicDungeonConfig
