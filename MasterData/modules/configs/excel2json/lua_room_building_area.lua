-- chunkname: @modules/configs/excel2json/lua_room_building_area.lua

module("modules.configs.excel2json.lua_room_building_area", package.seeall)

local lua_room_building_area = {}
local fields = {
	id = 1,
	icon = 3,
	area = 2,
	occupy = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_building_area.onLoad(json)
	lua_room_building_area.configList, lua_room_building_area.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building_area
