-- chunkname: @modules/configs/excel2json/lua_story_audio_effect.lua

module("modules.configs.excel2json.lua_story_audio_effect", package.seeall)

local lua_story_audio_effect = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_effect.onLoad(json)
	lua_story_audio_effect.configList, lua_story_audio_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_effect
