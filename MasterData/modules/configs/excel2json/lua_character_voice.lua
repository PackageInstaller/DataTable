-- chunkname: @modules/configs/excel2json/lua_character_voice.lua

module("modules.configs.excel2json.lua_character_voice", package.seeall)

local lua_character_voice = {}
local fields = {
	jpmouth = 42,
	name = 4,
	motion = 24,
	type = 10,
	heroId = 1,
	unlockCondition = 6,
	thaiface = 39,
	jpcontent = 19,
	krmotion = 28,
	sortId = 3,
	frcontent = 22,
	displayTime = 48,
	twface = 33,
	skins = 5,
	addaudio = 15,
	show = 9,
	twcontent = 18,
	face = 32,
	frmotion = 30,
	enface = 35,
	content = 16,
	effectParams = 14,
	encontent = 17,
	twmouth = 41,
	effects = 13,
	kocontent = 20,
	twmotion = 25,
	thaicontent = 23,
	thaimouth = 47,
	jpface = 34,
	demouth = 45,
	enmouth = 43,
	param2 = 12,
	frmouth = 46,
	frface = 38,
	demotion = 29,
	decontent = 21,
	krmouth = 44,
	thaimotion = 31,
	mouth = 40,
	jpmotion = 26,
	param = 11,
	deface = 37,
	time = 8,
	audio = 2,
	enmotion = 27,
	stateCondition = 7,
	krface = 36
}
local primaryKey = {
	"heroId",
	"audio"
}
local mlStringKey = {
	name = 1
}

function lua_character_voice.onLoad(json)
	lua_character_voice.configList, lua_character_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_voice
