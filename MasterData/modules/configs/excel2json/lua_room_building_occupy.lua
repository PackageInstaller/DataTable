-- chunkname: @modules/configs/excel2json/lua_room_building_occupy.lua

module("modules.configs.excel2json.lua_room_building_occupy", package.seeall)

local lua_room_building_occupy = {}
local fields = {
	id = 1,
	icon = 2,
	occupyNum = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_building_occupy.onLoad(json)
	lua_room_building_occupy.configList, lua_room_building_occupy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building_occupy
