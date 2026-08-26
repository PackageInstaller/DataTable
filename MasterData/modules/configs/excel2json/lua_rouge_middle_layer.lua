-- chunkname: @modules/configs/excel2json/lua_rouge_middle_layer.lua

module("modules.configs.excel2json.lua_rouge_middle_layer", package.seeall)

local lua_rouge_middle_layer = {}
local fields = {
	leavePosUnlockType = 10,
	name = 3,
	leavePosUnlockParam = 11,
	dayOrNight = 13,
	pointPos = 7,
	empty = 14,
	path = 12,
	pathPointPos = 8,
	pathSelect = 5,
	leavePos = 9,
	id = 1,
	version = 2,
	nextLayer = 4,
	mapRes = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_middle_layer.onLoad(json)
	lua_rouge_middle_layer.configList, lua_rouge_middle_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_middle_layer
