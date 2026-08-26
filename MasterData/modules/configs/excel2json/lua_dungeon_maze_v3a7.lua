-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_v3a7.lua

module("modules.configs.excel2json.lua_dungeon_maze_v3a7", package.seeall)

local lua_dungeon_maze_v3a7 = {}
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

function lua_dungeon_maze_v3a7.onLoad(json)
	lua_dungeon_maze_v3a7.configList, lua_dungeon_maze_v3a7.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_maze_v3a7
