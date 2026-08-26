-- chunkname: @modules/configs/excel2json/lua_fight_voice.lua

module("modules.configs.excel2json.lua_fight_voice", package.seeall)

local lua_fight_voice = {}
local fields = {
	audio_type3 = 4,
	audio_type9 = 10,
	audio_type4 = 5,
	skinId = 1,
	audio_type1 = 2,
	audio_type10 = 11,
	audio_type2 = 3,
	audio_type7 = 8,
	audio_type8 = 9,
	audio_type5 = 6,
	audio_type6 = 7
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_voice.onLoad(json)
	lua_fight_voice.configList, lua_fight_voice.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_voice
