-- chunkname: @modules/configs/excel2json/lua_story_text_reflect.lua

module("modules.configs.excel2json.lua_story_text_reflect", package.seeall)

local lua_story_text_reflect = {}
local fields = {
	id = 1,
	normalText = 3,
	magicText = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_story_text_reflect.onLoad(json)
	lua_story_text_reflect.configList, lua_story_text_reflect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_text_reflect
