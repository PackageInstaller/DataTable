-- chunkname: @modules/configs/excel2json/lua_sodache_choice.lua

module("modules.configs.excel2json.lua_sodache_choice", package.seeall)

local lua_sodache_choice = {}
local fields = {
	choiceIds0 = 16,
	descBigSuccess = 20,
	verifyCard = 9,
	verifyDesc = 11,
	initialSelect = 3,
	eventId = 2,
	selectCond = 5,
	desc = 13,
	descLose = 14,
	dialogSuccess = 18,
	choiceIds1 = 19,
	autoCard = 7,
	forceCard = 8,
	dialogBigSuccess = 21,
	choiceIds2 = 22,
	baseDice = 6,
	descSuccess = 17,
	dialogDefault = 4,
	verifyCond = 10,
	dialogLose = 15,
	id = 1,
	battleList = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descLose = 3,
	descBigSuccess = 5,
	verifyDesc = 1,
	descSuccess = 4,
	desc = 2
}

function lua_sodache_choice.onLoad(json)
	lua_sodache_choice.configList, lua_sodache_choice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_choice
