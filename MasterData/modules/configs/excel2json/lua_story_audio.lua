-- chunkname: @modules/configs/excel2json/lua_story_audio.lua

module("modules.configs.excel2json.lua_story_audio", package.seeall)

local lua_story_audio = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio.onLoad(json)
	lua_story_audio.configList, lua_story_audio.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio
