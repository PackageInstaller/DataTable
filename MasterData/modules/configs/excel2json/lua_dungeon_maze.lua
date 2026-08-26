-- chunkname: @modules/configs/excel2json/lua_dungeon_maze.lua

module("modules.configs.excel2json.lua_dungeon_maze", package.seeall)

local lua_dungeon_maze = {}
local fields = {
	dialogid = 5,
	celltype = 3,
	id = 1,
	cellId = 2,
	evenid = 4
}
local primaryKey = {
	"id",
	"cellId"
}
local mlStringKey = {
	dialogid = 1
}

function lua_dungeon_maze.onLoad(json)
	lua_dungeon_maze.configList, lua_dungeon_maze.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_maze
