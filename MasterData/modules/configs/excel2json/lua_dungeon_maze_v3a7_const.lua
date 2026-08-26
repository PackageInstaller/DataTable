-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_v3a7_const.lua

module("modules.configs.excel2json.lua_dungeon_maze_v3a7_const", package.seeall)

local lua_dungeon_maze_v3a7_const = {}
local fields = {
	id = 1,
	size = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dungeon_maze_v3a7_const.onLoad(json)
	lua_dungeon_maze_v3a7_const.configList, lua_dungeon_maze_v3a7_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_maze_v3a7_const
