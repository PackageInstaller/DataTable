-- chunkname: @modules/configs/excel2json/lua_story_element.lua

module("modules.configs.excel2json.lua_story_element", package.seeall)

local lua_story_element = {}
local fields = {
	id = 1,
	elementId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_element.onLoad(json)
	lua_story_element.configList, lua_story_element.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_element
