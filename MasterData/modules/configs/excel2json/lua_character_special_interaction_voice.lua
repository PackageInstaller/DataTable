-- chunkname: @modules/configs/excel2json/lua_character_special_interaction_voice.lua

module("modules.configs.excel2json.lua_character_special_interaction_voice", package.seeall)

local lua_character_special_interaction_voice = {}
local fields = {
	waitVoiceParams = 4,
	protectionTime = 6,
	time = 2,
	timeoutVoice = 5,
	id = 1,
	statusParams = 7,
	waitVoice = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_character_special_interaction_voice.onLoad(json)
	lua_character_special_interaction_voice.configList, lua_character_special_interaction_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_special_interaction_voice
