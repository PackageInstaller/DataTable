-- chunkname: @modules/configs/excel2json/lua_college_story_theme.lua

module("modules.configs.excel2json.lua_college_story_theme", package.seeall)

local lua_college_story_theme = {}
local fields = {
	id = 1,
	title = 2,
	pic = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_college_story_theme.onLoad(json)
	lua_college_story_theme.configList, lua_college_story_theme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_story_theme
