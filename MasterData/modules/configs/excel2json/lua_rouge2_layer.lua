-- chunkname: @modules/configs/excel2json/lua_rouge2_layer.lua

module("modules.configs.excel2json.lua_rouge2_layer", package.seeall)

local lua_rouge2_layer = {}
local fields = {
	pathPos = 13,
	name = 2,
	desc = 10,
	pathRes = 12,
	levelId = 19,
	sceneId = 18,
	bgm = 17,
	unlock = 8,
	gridPosType1 = 20,
	crossDesc = 11,
	weather = 3,
	gridPosType2 = 21,
	startStoryId = 6,
	endStoryId = 7,
	mapRes = 5,
	middleLayerId = 4,
	iconRes = 14,
	dayOrNight = 16,
	id = 1,
	iconPos = 15,
	gridPosType3 = 22,
	nameEn = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	crossDesc = 3,
	name = 1,
	desc = 2
}

function lua_rouge2_layer.onLoad(json)
	lua_rouge2_layer.configList, lua_rouge2_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_layer
