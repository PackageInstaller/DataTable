-- chunkname: @modules/configs/excel2json/lua_character.lua

module("modules.configs.excel2json.lua_character", package.seeall)

local lua_character = {}
local fields = {
	resistance = 23,
	name = 2,
	duplicateItem = 18,
	skinId = 4,
	deviceId = 13,
	uniqueSkill_point = 12,
	nameEng = 26,
	career = 5,
	duplicateItemSpecial = 19,
	desc2 = 37,
	skill = 21,
	battleTag = 9,
	ai = 16,
	trust = 33,
	powerMax = 15,
	birthdayBonus = 34,
	roleBirthday = 32,
	isSP = 41,
	useDesc = 36,
	heroType = 30,
	mvskinId = 38,
	stat = 39,
	rare = 6,
	firstItem = 17,
	actor = 31,
	duplicateItem2 = 20,
	initials = 3,
	spName = 42,
	id = 1,
	qteGroupId = 14,
	gender = 8,
	desc = 35,
	equipRec = 10,
	oriHeroId = 43,
	dmgType = 7,
	signature = 27,
	exSkill = 22,
	isOnline = 29,
	characterTag = 25,
	photoFrameBg = 28,
	school = 24,
	rank = 11,
	statShare = 40
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 5,
	name = 1,
	useDesc = 4,
	characterTag = 2,
	spName = 6,
	desc = 3
}

function lua_character.onLoad(json)
	lua_character.configList, lua_character.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character
