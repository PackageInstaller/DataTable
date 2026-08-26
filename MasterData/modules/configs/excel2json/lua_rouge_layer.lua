-- chunkname: @modules/configs/excel2json/lua_rouge_layer.lua

module("modules.configs.excel2json.lua_rouge_layer", package.seeall)

local lua_rouge_layer = {}
local fields = {
	version = 2,
	name = 3,
	ruleIdVersion = 5,
	unlockType = 10,
	levelId = 22,
	pathPos = 17,
	iconPos = 18,
	desc = 13,
	bgm = 20,
	crossDesc = 14,
	sceneId = 21,
	ruleIdInstead = 6,
	startStoryId = 8,
	endStoryId = 9,
	mapRes = 7,
	middleLayerId = 4,
	unlockParam = 11,
	iconRes = 15,
	dayOrNight = 19,
	id = 1,
	pathRes = 16,
	nameEn = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	crossDesc = 3,
	name = 1,
	desc = 2
}

function lua_rouge_layer.onLoad(json)
	lua_rouge_layer.configList, lua_rouge_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_layer
