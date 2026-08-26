-- chunkname: @modules/configs/excel2json/lua_dungeon_jump_event.lua

module("modules.configs.excel2json.lua_dungeon_jump_event", package.seeall)

local lua_dungeon_jump_event = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_dungeon_jump_event.onLoad(json)
	lua_dungeon_jump_event.configList, lua_dungeon_jump_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_jump_event
