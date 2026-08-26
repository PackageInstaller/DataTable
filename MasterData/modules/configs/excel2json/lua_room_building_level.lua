-- chunkname: @modules/configs/excel2json/lua_room_building_level.lua

module("modules.configs.excel2json.lua_room_building_level", package.seeall)

local lua_room_building_level = {}
local fields = {
	nameEn = 10,
	name = 3,
	useDesc = 4,
	path = 11,
	levelUpIcon = 7,
	rare = 9,
	desc = 5,
	id = 1,
	icon = 6,
	rewardIcon = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_room_building_level.onLoad(json)
	lua_room_building_level.configList, lua_room_building_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building_level
