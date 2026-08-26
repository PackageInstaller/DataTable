-- chunkname: @modules/configs/excel2json/lua_rouge2_middle_layer.lua

module("modules.configs.excel2json.lua_rouge2_middle_layer", package.seeall)

local lua_rouge2_middle_layer = {}
local fields = {
	nameWeather = 3,
	name = 2,
	path = 11,
	dayOrNight = 12,
	pointPos = 7,
	empty = 13,
	leavePosUnlock = 10,
	pathPointPos = 8,
	pathSelect = 5,
	leavePos = 9,
	id = 1,
	nextLayer = 4,
	mapRes = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameWeather = 2,
	name = 1
}

function lua_rouge2_middle_layer.onLoad(json)
	lua_rouge2_middle_layer.configList, lua_rouge2_middle_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_middle_layer
