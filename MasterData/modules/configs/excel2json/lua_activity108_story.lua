-- chunkname: @modules/configs/excel2json/lua_activity108_story.lua

module("modules.configs.excel2json.lua_activity108_story", package.seeall)

local lua_activity108_story = {}
local fields = {
	id = 1,
	story = 3,
	bind = 4,
	params = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity108_story.onLoad(json)
	lua_activity108_story.configList, lua_activity108_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_story
