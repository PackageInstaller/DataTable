-- chunkname: @modules/configs/excel2json/lua_room_building_skin.lua

module("modules.configs.excel2json.lua_room_building_skin", package.seeall)

local lua_room_building_skin = {}
local fields = {
	itemId = 3,
	name = 4,
	useDesc = 5,
	path = 11,
	vehicleId = 12,
	rare = 9,
	desc = 6,
	buildingId = 2,
	id = 1,
	icon = 7,
	rewardIcon = 8,
	nameEn = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_room_building_skin.onLoad(json)
	lua_room_building_skin.configList, lua_room_building_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building_skin
