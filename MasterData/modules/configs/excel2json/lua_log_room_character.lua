-- chunkname: @modules/configs/excel2json/lua_log_room_character.lua

module("modules.configs.excel2json.lua_log_room_character", package.seeall)

local lua_log_room_character = {}
local fields = {
	id = 1,
	upTime = 3,
	tag = 4,
	logkind = 2,
	content = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_log_room_character.onLoad(json)
	lua_log_room_character.configList, lua_log_room_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_log_room_character
