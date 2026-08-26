-- chunkname: @modules/logic/versionactivity2_7/coopergarland/config/CooperGarlandConfig.lua

module("modules.logic.versionactivity2_7.coopergarland.config.CooperGarlandConfig", package.seeall)

local CooperGarlandConfig = class("CooperGarlandConfig", BaseConfig)

function CooperGarlandConfig:reqConfigNames()
	return {
		"activity192_const",
		"activity192_episode",
		"activity192_task",
		"activity192_game",
		"activity192_map",
		"activity192_component_type"
	}
end

function CooperGarlandConfig:onInit()
	self._actTaskDict = {}
	self._actEpisodeDict = {}
	self._map2ComponentList = {}
end

function CooperGarlandConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function CooperGarlandConfig:activity192_mapConfigLoaded(configTable)
	self._map2ComponentList = {}

	for _, cfg in ipairs(configTable.configList) do
		local mapId = cfg.mapId
		local componentList = self._map2ComponentList[mapId]

		if not componentList then
			componentList = {}
			self._map2ComponentList[mapId] = componentList
		end

		componentList[#componentList + 1] = cfg.componentId
	end
end

function CooperGarlandConfig:getAct192ConstCfg(constId, nilError)
	local cfg = lua_activity192_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("CooperGarlandConfig:getAct192ConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function CooperGarlandConfig:getAct192Const(constId, isToNumber)
	local result
	local cfg = self:getAct192ConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function CooperGarlandConfig:getAct192EpisodeCfg(actId, episodeId, nilError)
	if lua_activity192_episode.configDict[actId] then
		if not lua_activity192_episode.configDict[actId] and nilError then
			logError(string.format("CooperGarlandConfig:getAct192EpisodeCfg error, cfg is nil, actId:%s, episodeId:%s", actId, episodeId))
		end

		return lua_activity192_episode.configDict[actId]
	end
end

function CooperGarlandConfig:getEpisodeIdList(actId, nilError)
	local result = {}
	local episodeDict = lua_activity192_episode.configDict[actId]

	if episodeDict then
		result = self._actEpisodeDict[actId]

		if not self._actEpisodeDict[actId] then
			result = {}
			self._actEpisodeDict = result

			for _, cfg in ipairs(lua_activity192_episode.configList) do
				if actId == cfg.activityId and not cfg.isExtra then
					result[#result + 1] = cfg.episodeId
				end
			end
		end
	elseif nilError then
		logError(string.format("CooperGarlandConfig:getEpisodeIdList error, cfg is nil, actId:%s", actId))
	end

	return result
end

function CooperGarlandConfig:getEpisodeName(actId, episodeId)
	local cfg = self:getAct192EpisodeCfg(actId, episodeId, true)

	return (cfg or nil) and (cfg.name or "")
end

function CooperGarlandConfig:getGameId(actId, episodeId)
	local cfg = self:getAct192EpisodeCfg(actId, episodeId, true)

	return cfg and cfg.gameId
end

function CooperGarlandConfig:isGameEpisode(actId, episodeId)
	local gameId = self:getGameId(actId, episodeId)

	return gameId and gameId ~= 0
end

function CooperGarlandConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getAct192EpisodeCfg(actId, episodeId, true)

	return cfg and cfg.storyBefore
end

function CooperGarlandConfig:getStoryClear(actId, episodeId)
	local cfg = self:getAct192EpisodeCfg(actId, episodeId, true)

	return cfg and cfg.storyClear
end

function CooperGarlandConfig:getExtraEpisode(actId, nilError)
	local result
	local episodeDict = lua_activity192_episode.configDict[actId]

	if episodeDict then
		for episodeId, cfg in pairs(episodeDict) do
			if cfg.isExtra then
				result = episodeId

				break
			end
		end
	elseif nilError then
		logError(string.format("CooperGarlandConfig:getExtraEpisode error, cfg is nil, actId:%s", actId))
	end

	return result
end

function CooperGarlandConfig:isExtraEpisode(actId, episodeId)
	local cfg = self:getAct192EpisodeCfg(actId, episodeId, true)

	return cfg and cfg.isExtra
end

function CooperGarlandConfig:getAct192TaskCfg(actId, taskId, nilError)
	local cfg = lua_activity192_task.configDict[taskId]

	if nilError then
		if cfg then
			if cfg.activityId ~= actId then
				logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, actId error, actId:%s, taskId:%s, cfg actId:%s", actId, taskId, cfg.activityId))
			end
		else
			logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, cfg is nil, actId:%s, taskId:%s", actId, taskId))
		end
	end

	return cfg
end

function CooperGarlandConfig:getTaskList(actId)
	local result = self._actTaskDict[actId]

	if not result then
		result = {}
		self._actTaskDict = result

		for _, cfg in pairs(lua_activity192_task.configDict) do
			if actId == cfg.activityId then
				result[#result + 1] = cfg
			end
		end
	end

	return result
end

function CooperGarlandConfig:getAct192GameCfg(gameId, nilError)
	local cfg = lua_activity192_game.configDict[gameId]

	if not cfg and nilError then
		logError(string.format("CooperGarlandConfig:getAct192GameCfg error, cfg is nil, gameId:%s", gameId))
	end

	return cfg
end

function CooperGarlandConfig:getMapId(gameId, round)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.maps[round]
end

function CooperGarlandConfig:getMaxRound(gameId)
	local cfg = self:getAct192GameCfg(gameId, true)

	return (cfg or nil) and #cfg.maps
end

function CooperGarlandConfig:getRemoveCount(gameId, round)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.removeCount[round]
end

function CooperGarlandConfig:getPanelImage(gameId)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.panelImage
end

function CooperGarlandConfig:getScenePath(gameId)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.scenePath
end

function CooperGarlandConfig:getCubeOpenAnim(gameId)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.cubeOpenAnim
end

function CooperGarlandConfig:getCubeSwitchAnim(gameId)
	local cfg = self:getAct192GameCfg(gameId, true)

	return cfg and cfg.cubeSwitchAnim
end

function CooperGarlandConfig:getAct192MapComponentCfg(mapId, componentId, nilError)
	if lua_activity192_map.configDict[mapId] then
		if not lua_activity192_map.configDict[mapId] and nilError then
			logError(string.format("CooperGarlandConfig:getAct192MapComponentCfg error, cfg is nil, mapId:%s, componentId:%s", mapId, componentId))
		end

		return lua_activity192_map.configDict[mapId]
	end
end

function CooperGarlandConfig:getMapComponentList(mapId)
	if self._map2ComponentList then
		if not self._map2ComponentList[mapId] then
			return {}
		end
	end
end

function CooperGarlandConfig:getMapComponentType(mapId, componentId)
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	return cfg and cfg.componentType
end

function CooperGarlandConfig:getMapComponentSize(mapId, componentId)
	local w, h = 0, 0
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	if cfg then
		w = cfg.width
		h = cfg.height
	end

	return w, h
end

function CooperGarlandConfig:getMapComponentColliderSize(mapId, componentId)
	local w, h = 0, 0
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	if cfg then
		w = cfg.colliderWidth
		h = cfg.colliderHeight
	end

	return w, h
end

function CooperGarlandConfig:getMapComponentColliderOffset(mapId, componentId)
	local x, y = 0, 0
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	if cfg then
		x = cfg.colliderOffsetX
		y = cfg.colliderOffsetY
	end

	return x, y
end

function CooperGarlandConfig:getMapComponentScale(mapId, componentId)
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	return cfg and cfg.scale
end

function CooperGarlandConfig:getMapComponentPos(mapId, componentId)
	local x, y
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	if cfg then
		x = cfg.posX
		y = cfg.posY
	end

	return x, y
end

function CooperGarlandConfig:getMapComponentRotation(mapId, componentId)
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	return cfg and cfg.rotation
end

function CooperGarlandConfig:getMapComponentExtraParams(mapId, componentId)
	local cfg = self:getAct192MapComponentCfg(mapId, componentId, true)

	return cfg and cfg.extraParams
end

function CooperGarlandConfig:getStoryCompId(mapId, guideId)
	local componentIdList = self:getMapComponentList(mapId)

	for _, componentId in ipairs(componentIdList) do
		local type = self:getMapComponentType(mapId, componentId)
		local params = self:getMapComponentExtraParams(mapId, componentId)

		if type == CooperGarlandEnum.ComponentType.Story and tonumber(params) == guideId then
			return componentId
		end
	end
end

function CooperGarlandConfig:getAct192ComponentTypeCfg(componentType, nilError)
	local cfg = lua_activity192_component_type.configDict[componentType]

	if not cfg and nilError then
		logError(string.format("CooperGarlandConfig:getAct192ComponentTypeCfg error, cfg is nil, componentType:%s", componentType))
	end

	return cfg
end

function CooperGarlandConfig:getAllComponentResPath()
	local result = {}

	for _, cfg in ipairs(lua_activity192_component_type.configList) do
		result[#result + 1] = cfg.path
	end

	return result
end

function CooperGarlandConfig:getComponentTypePath(componentType)
	local cfg = self:getAct192ComponentTypeCfg(componentType, true)

	return cfg and cfg.path
end

CooperGarlandConfig.instance = CooperGarlandConfig.New()

return CooperGarlandConfig
