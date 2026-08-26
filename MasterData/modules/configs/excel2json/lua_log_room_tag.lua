-- chunkname: @modules/configs/excel2json/lua_log_room_tag.lua

module("modules.configs.excel2json.lua_log_room_tag", package.seeall)

local lua_log_room_tag = {}
local fields = {
	id = 1,
	characterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_log_room_tag.onLoad(json)
	lua_log_room_tag.configList, lua_log_room_tag.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_log_room_tag
