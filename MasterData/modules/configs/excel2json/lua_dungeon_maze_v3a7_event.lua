-- chunkname: @modules/configs/excel2json/lua_dungeon_maze_v3a7_event.lua

module("modules.configs.excel2json.lua_dungeon_maze_v3a7_event", package.seeall)

local lua_dungeon_maze_v3a7_event = {}
local fields = {
	type = 2,
	desc = 3,
	evenid = 1
}
local primaryKey = {
	"evenid"
}
local mlStringKey = {
	desc = 1
}

function lua_dungeon_maze_v3a7_event.onLoad(json)
	lua_dungeon_maze_v3a7_event.configList, lua_dungeon_maze_v3a7_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_maze_v3a7_event
