-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_const.lua

module("modules.configs.excel2json.lua_dungeon_maze_const", package.seeall)

local lua_dungeon_maze_const = {}
local fields = {
	id = 1,
	size = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dungeon_maze_const.onLoad(json)
	lua_dungeon_maze_const.configList, lua_dungeon_maze_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_maze_const
