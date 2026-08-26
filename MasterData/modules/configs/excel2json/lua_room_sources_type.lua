-- chunkname: @modules/configs/excel2json/lua_room_sources_type.lua

module("modules.configs.excel2json.lua_room_sources_type", package.seeall)

local lua_room_sources_type = {}
local fields = {
	showType = 7,
	name = 2,
	bgColor = 6,
	nameColor = 5,
	id = 1,
	bgIcon = 4,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_room_sources_type.onLoad(json)
	lua_room_sources_type.configList, lua_room_sources_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_sources_type
