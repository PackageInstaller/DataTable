-- chunkname: @modules/configs/excel2json/lua_character.lua

module("modules.configs.excel2json.lua_character", package.seeall)

local lua_character = {}
local fields = {
	resistance = 22,
	name = 2,
	duplicateItem = 17,
	skinId = 4,
	deviceId = 13,
	uniqueSkill_point = 12,
	nameEng = 25,
	career = 5,
	duplicateItemSpecial = 18,
	desc2 = 36,
	skill = 20,
	battleTag = 9,
	ai = 15,
	trust = 32,
	powerMax = 14,
	birthdayBonus = 33,
	roleBirthday = 31,
	isSP = 40,
	useDesc = 35,
	heroType = 29,
	mvskinId = 37,
	stat = 38,
	rare = 6,
	firstItem = 16,
	actor = 30,
	duplicateItem2 = 19,
	initials = 3,
	id = 1,
	gender = 8,
	desc = 34,
	equipRec = 10,
	dmgType = 7,
	signature = 26,
	exSkill = 21,
	isOnline = 28,
	characterTag = 24,
	photoFrameBg = 27,
	school = 23,
	rank = 11,
	statShare = 39
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 5,
	name = 1,
	useDesc = 4,
	characterTag = 2,
	desc = 3
}

function lua_character.onLoad(json)
	lua_character.configList, lua_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character
