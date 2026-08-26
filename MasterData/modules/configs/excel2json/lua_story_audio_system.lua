-- chunkname: @modules/configs/excel2json/lua_story_audio_system.lua

module("modules.configs.excel2json.lua_story_audio_system", package.seeall)

local lua_story_audio_system = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_system.onLoad(json)
	lua_story_audio_system.configList, lua_story_audio_system.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_system
