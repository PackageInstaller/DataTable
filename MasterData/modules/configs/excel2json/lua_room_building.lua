-- chunkname: @modules/configs/excel2json/lua_room_building.lua

module("modules.configs.excel2json.lua_room_building", package.seeall)

local lua_room_building = {}
local fields = {
	canPlaceBlock = 31,
	name = 4,
	buildingType = 7,
	sound = 22,
	rotate = 16,
	useDesc = 5,
	alphaThreshold = 20,
	path = 21,
	canLevelUp = 35,
	isAreaMainBuilding = 36,
	sourcesType = 13,
	vehicleType = 29,
	icon = 8,
	center = 3,
	buildDegree = 26,
	sources = 14,
	vehicleId = 30,
	buildingShowType = 15,
	audioExtendIds = 25,
	rare = 10,
	id = 1,
	rewardIcon = 9,
	nameEn = 12,
	uiScale = 18,
	audioExtendType = 24,
	canExchange = 37,
	desc = 6,
	linkBlock = 33,
	placeAudio = 23,
	crossload = 28,
	areaId = 2,
	costResource = 27,
	replaceBlock = 32,
	offset = 17,
	numLimit = 11,
	reflerction = 34,
	dragUpHeight = 19
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_room_building.onLoad(json)
	lua_room_building.configList, lua_room_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building
