-- chunkname: @modules/configs/excel2json/lua_story_leadherospine.lua

module("modules.configs.excel2json.lua_story_leadherospine", package.seeall)

local lua_story_leadherospine = {}
local fields = {
	id = 1,
	icon = 2,
	resType = 3,
	path = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_leadherospine.onLoad(json)
	lua_story_leadherospine.configList, lua_story_leadherospine.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_leadherospine
