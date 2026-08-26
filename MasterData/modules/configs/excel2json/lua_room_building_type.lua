-- chunkname: @modules/configs/excel2json/lua_room_building_type.lua

module("modules.configs.excel2json.lua_room_building_type", package.seeall)

local lua_room_building_type = {}
local fields = {
	icon = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_room_building_type.onLoad(json)
	lua_room_building_type.configList, lua_room_building_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building_type
