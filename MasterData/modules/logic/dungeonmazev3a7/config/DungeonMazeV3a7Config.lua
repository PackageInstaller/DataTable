-- chunkname: @modules/logic/dungeonmazev3a7/config/DungeonMazeV3a7Config.lua

module("modules.logic.dungeonmazev3a7.config.DungeonMazeV3a7Config", package.seeall)

local DungeonMazeV3a7Config = class("DungeonMazeV3a7Config", BaseConfig)

function DungeonMazeV3a7Config:ctor()
	self._dungeonMazeMapCfg = nil
	self._dungeonMazeConstCfg = nil
	self._dungeonMazeEventCfg = nil
end

function DungeonMazeV3a7Config:reqConfigNames()
	return {
		"dungeon_maze_v3a7",
		"dungeon_maze_v3a7_event",
		"dungeon_maze_v3a7_const"
	}
end

function DungeonMazeV3a7Config:onConfigLoaded(configName, configTable)
	if configName == "dungeon_maze_v3a7" then
		self._dungeonMazeMapCfg = configTable

		self:_initMazeMapCfg()
	elseif configName == "dungeon_maze_v3a7_event" then
		self._dungeonMazeEventCfg = configTable
	elseif configName == "dungeon_maze_v3a7_const" then
		self._dungeonMazeConstCfg = configTable
	end
end

function DungeonMazeV3a7Config:_initMazeMapCfg()
	self._endCellId = -1

	for id, v in ipairs(lua_dungeon_maze_v3a7.configList) do
		if v.celltype == DungeonMazeV3a7Enum.CellType.End then
			self._endCellId = v.cellId

			break
		end
	end
end

function DungeonMazeV3a7Config:getEndCellId()
	return self._endCellId
end

function DungeonMazeV3a7Config:getMazeMap(mapId)
	return self._dungeonMazeMapCfg.configDict[mapId]
end

function DungeonMazeV3a7Config:getMazeEventCfg(eventId)
	return self._dungeonMazeEventCfg.configDict[eventId]
end

function DungeonMazeV3a7Config:getMazeGameConst(constId)
	return self._dungeonMazeConstCfg.configDict[constId]
end

DungeonMazeV3a7Config.instance = DungeonMazeV3a7Config.New()

return DungeonMazeV3a7Config
