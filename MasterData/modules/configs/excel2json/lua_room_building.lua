-- chunkname: @modules/configs/excel2json/lua_room_building.lua

module("modules.configs.excel2json.lua_room_building", package.seeall)

local lua_room_building = {}
local fields = {
	alphaThreshold = 22,
	name = 4,
	rotate = 18,
	sound = 24,
	gatherDesc = 17,
	buildingType = 7,
	useDesc = 5,
	path = 23,
	canPlaceBlock = 33,
	canLevelUp = 37,
	sourcesType = 13,
	vehicleType = 31,
	isAreaMainBuilding = 38,
	icon = 8,
	center = 3,
	buildDegree = 28,
	sources = 14,
	vehicleId = 32,
	buildingShowType = 15,
	audioExtendIds = 27,
	rare = 10,
	produceDesc = 16,
	id = 1,
	rewardIcon = 9,
	nameEn = 12,
	uiScale = 20,
	audioExtendType = 26,
	canExchange = 39,
	desc = 6,
	linkBlock = 35,
	placeAudio = 25,
	crossload = 30,
	areaId = 2,
	costResource = 29,
	replaceBlock = 34,
	offset = 19,
	numLimit = 11,
	reflerction = 36,
	dragUpHeight = 21
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	produceDesc = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_room_building.onLoad(json)
	lua_room_building.configList, lua_room_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_building
