-- chunkname: @modules/logic/dungeon/config/DungeonGameConfig.lua

module("modules.logic.dungeon.config.DungeonGameConfig", package.seeall)

local DungeonGameConfig = class("DungeonGameConfig", BaseConfig)

function DungeonGameConfig:ctor()
	self._dungeonMazeMapCfg = nil
	self._dungeonMazeConstCfg = nil
	self._dungeonMazeEventCfg = nil
	self._jumpGameMapCfg = nil
	self._jumpGameConstCfg = nil
	self._jumpGameEventCfg = nil
end

function DungeonGameConfig:reqConfigNames()
	return {
		"dungeon_maze",
		"dungeon_maze_event",
		"dungeon_maze_const",
		"dungeon_jump",
		"dungeon_jump_event",
		"dungeon_jump_const"
	}
end

function DungeonGameConfig:onConfigLoaded(configName, configTable)
	if configName == "dungeon_maze" then
		self._dungeonMazeMapCfg = configTable
	elseif configName == "dungeon_maze_event" then
		self._dungeonMazeEventCfg = configTable
	elseif configName == "dungeon_maze_const" then
		self._dungeonMazeConstCfg = configTable
	elseif configName == "dungeon_jump" then
		self._jumpGameMapCfg = configTable
	elseif configName == "dungeon_jump_event" then
		self._jumpGameEventCfg = configTable
	elseif configName == "dungeon_jump_const" then
		self._jumpGameConstCfg = configTable
	end
end

function DungeonGameConfig:getJumpMap(mapId)
	return self._jumpGameMapCfg.configDict[mapId]
end

function DungeonGameConfig:getJumpGameEventCfg(eventId)
	return self._jumpGameEventCfg.configDict[eventId]
end

function DungeonGameConfig:getJumpGameConst(constId)
	return self._jumpGameConstCfg.configDict[constId]
end

function DungeonGameConfig:getMazeMap(mapId)
	return self._dungeonMazeMapCfg.configDict[mapId]
end

function DungeonGameConfig:getMazeEventCfg(eventId)
	return self._dungeonMazeEventCfg.configDict[eventId]
end

function DungeonGameConfig:getMazeGameConst(constId)
	return self._dungeonMazeConstCfg.configDict[constId]
end

DungeonGameConfig.instance = DungeonGameConfig.New()

return DungeonGameConfig
