-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_option.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_option", package.seeall)

local lua_hero_story_mode_v4a0_option = {}
local fields = {
	id = 1,
	type = 4,
	content = 2,
	result = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	result = 2
}

function lua_hero_story_mode_v4a0_option.onLoad(json)
	lua_hero_story_mode_v4a0_option.configList, lua_hero_story_mode_v4a0_option.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v4a0_option
