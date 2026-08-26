-- chunkname: @modules/configs/excel2json/lua_dungeon_jump_const.lua

module("modules.configs.excel2json.lua_dungeon_jump_const", package.seeall)

local lua_dungeon_jump_const = {}
local fields = {
	id = 1,
	size = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_dungeon_jump_const.onLoad(json)
	lua_dungeon_jump_const.configList, lua_dungeon_jump_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_dungeon_jump_const
