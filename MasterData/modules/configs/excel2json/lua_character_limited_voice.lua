-- chunkname: @modules/configs/excel2json/lua_character_limited_voice.lua

module("modules.configs.excel2json.lua_character_limited_voice", package.seeall)

local lua_character_limited_voice = {}
local fields = {
	twcontent = 6,
	encontent = 5,
	frcontent = 10,
	audio = 2,
	decontent = 9,
	thaicontent = 11,
	content = 4,
	jpcontent = 7,
	kocontent = 8,
	id = 1,
	addaudio = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_limited_voice.onLoad(json)
	lua_character_limited_voice.configList, lua_character_limited_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_limited_voice
