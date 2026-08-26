-- chunkname: @modules/configs/excel2json/lua_story_audio_main.lua

module("modules.configs.excel2json.lua_story_audio_main", package.seeall)

local lua_story_audio_main = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_main.onLoad(json)
	lua_story_audio_main.configList, lua_story_audio_main.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_main
