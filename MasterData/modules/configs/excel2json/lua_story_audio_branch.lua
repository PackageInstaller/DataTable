-- chunkname: @modules/configs/excel2json/lua_story_audio_branch.lua

module("modules.configs.excel2json.lua_story_audio_branch", package.seeall)

local lua_story_audio_branch = {}
local fields = {
	id = 1,
	bankName = 3,
	eventName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_audio_branch.onLoad(json)
	lua_story_audio_branch.configList, lua_story_audio_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_audio_branch
