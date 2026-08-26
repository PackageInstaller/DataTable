-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/config/TowerV3a7Config.lua

module("modules.logic.versionactivity3_7.towerv3a7.config.TowerV3a7Config", package.seeall)

local TowerV3a7Config = class("TowerV3a7Config", BaseConfig)

function TowerV3a7Config:reqConfigNames()
	return {
		"tower_v3a7_map",
		"tower_v3a7_const",
		"tower_v3a7_chess",
		"tower_v3a7_story"
	}
end

function TowerV3a7Config:onInit()
	return
end

function TowerV3a7Config:onConfigLoaded(configName, configTable)
	if configName == "tower_v3a7_const" then
		self:_initConst()
	elseif configName == "tower_v3a7_chess" then
		self:_initChess()
	end
end

function TowerV3a7Config:_initChess()
	self._chessMap = {}

	for i, v in ipairs(lua_tower_v3a7_chess.configList) do
		if v.map > 0 then
			self._chessMap[v.map] = self._chessMap[v.map] or {}

			table.insert(self._chessMap[v.map], v)
		else
			logError("TowerV3a7Config:_initChess map == 0 id:", v.id)
		end
	end
end

function TowerV3a7Config:getChessByMapId(mapId)
	local list = self._chessMap[mapId]

	if not list then
		logError("TowerV3a7Config:getChessByMapId mapId = " .. mapId .. " not found")

		return {}
	end

	return list
end

function TowerV3a7Config:_initConst()
	self._constParams = {}
	self._constParams.attackPerSecond = tonumber(lua_tower_v3a7_const.configDict[1001].value1)
	self._constParams.recoverPerSecond = tonumber(lua_tower_v3a7_const.configDict[1002].value1)
	self._constParams.enemyAttackProb1 = tonumber(lua_tower_v3a7_const.configDict[1003].value1)
	self._constParams.enemyAttackProb2 = tonumber(lua_tower_v3a7_const.configDict[1004].value1)
	self._constParams.enemyAttackProb3 = tonumber(lua_tower_v3a7_const.configDict[1005].value1)
end

function TowerV3a7Config:getConstParams()
	return self._constParams
end

function TowerV3a7Config.getMapConfig(elementId)
	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if not elementConfig then
		logError("TowerV3a7Config:getMapConfig elementConfig is nil id:", tostring(elementId))

		return
	end

	if elementConfig.type ~= DungeonEnum.ElementType.V3a7Tower then
		logError("TowerV3a7Config:getMapConfig elementConfig.type is not V3a7Tower id:", tostring(elementId))

		return
	end

	local mapId = tonumber(elementConfig.param)
	local mapConfig = mapId and lua_tower_v3a7_map.configDict[mapId]

	if not mapConfig then
		logError("TowerV3a7Config:getMapConfig mapConfig is nil id:", tostring(mapId))

		return
	end

	return mapConfig
end

function TowerV3a7Config.getChessConfig(id)
	local config = lua_tower_v3a7_chess.configDict[id]

	if not config then
		logError("TowerV3a7Config:getChessConfig config is nil id:", tostring(id))

		return
	end

	return config
end

function TowerV3a7Config.getStoryConfig(id)
	local storyList = lua_tower_v3a7_story.configDict[id]

	if not storyList then
		logError("TowerV3a7Config:getStoryConfig storyList is nil id:", tostring(id))

		return
	end

	local firstStepConfig = storyList[1]

	if not firstStepConfig then
		logError("TowerV3a7Config:getStoryConfig firstStepConfig is nil id:", tostring(id))

		return
	end

	local triggerParams = string.splitToNumber(firstStepConfig.occur, "#")

	if not triggerParams or #triggerParams <= 0 then
		logError("TowerV3a7Config:getStoryConfig triggerParams is nil id:", tostring(id))

		return
	end

	return storyList, triggerParams
end

TowerV3a7Config.instance = TowerV3a7Config.New()

return TowerV3a7Config
