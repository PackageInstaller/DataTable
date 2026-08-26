-- chunkname: @modules/configs/excel2json/lua_story_audio_switch.lua

module("modules.configs.excel2json.lua_story_audio_switch", package.seeall)

local lua_story_audio_switch = {}
local fields = {
	switchgroup = 2,
	id = 1,
	switchstate = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_switch.onLoad(json)
	lua_story_audio_switch.configList, lua_story_audio_switch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_switch
