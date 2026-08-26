-- chunkname: @modules/configs/excel2json/lua_rouge2_relics.lua

module("modules.configs.excel2json.lua_rouge2_relics", package.seeall)

local lua_rouge2_relics = {}
local fields = {
	isDisplay = 5,
	effect14 = 52,
	condition8 = 39,
	effect8 = 40,
	effect4 = 32,
	condition2 = 27,
	invisible = 23,
	unlock = 14,
	descSimply = 16,
	outUnlock = 6,
	career = 12,
	tag = 10,
	isHide = 8,
	condition15 = 53,
	effect2 = 28,
	condition7 = 37,
	name = 2,
	overlay = 24,
	narrativeDesc = 22,
	effect22 = 68,
	condition25 = 73,
	descUpdate = 19,
	condition22 = 67,
	effect25 = 74,
	unlockConditionDesc = 20,
	id = 1,
	condition10 = 43,
	condition16 = 55,
	isOff = 3,
	condition5 = 33,
	effect7 = 38,
	updateId = 18,
	condition17 = 57,
	condition9 = 41,
	sortId = 4,
	effect23 = 70,
	outUnlockDesc = 7,
	condition6 = 35,
	effect21 = 66,
	unlockEffectDesc = 21,
	condition12 = 47,
	effect20 = 64,
	effect13 = 50,
	condition23 = 69,
	effect5 = 34,
	condition24 = 71,
	effect11 = 46,
	effect12 = 48,
	condition19 = 61,
	condition3 = 29,
	effect10 = 44,
	attrUpdate = 17,
	icon = 13,
	effect6 = 36,
	condition21 = 65,
	rare = 9,
	effect17 = 58,
	effect9 = 42,
	condition1 = 25,
	effect16 = 56,
	effect1 = 26,
	condition13 = 49,
	effect3 = 30,
	condition14 = 51,
	desc = 15,
	condition18 = 59,
	attributeTag = 11,
	effect19 = 62,
	effect24 = 72,
	effect18 = 60,
	condition11 = 45,
	condition4 = 31,
	condition20 = 63,
	effect15 = 54
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockEffectDesc = 7,
	descSimply = 4,
	unlockConditionDesc = 6,
	outUnlockDesc = 2,
	narrativeDesc = 8,
	descUpdate = 5,
	name = 1,
	desc = 3
}

function lua_rouge2_relics.onLoad(json)
	lua_rouge2_relics.configList, lua_rouge2_relics.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_relics
