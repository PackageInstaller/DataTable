-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item_new_star.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item_new_star", package.seeall)

local lua_hero_story_mode_v3a9_item_new_star = {}
local fields = {
	level = 5,
	min = 2,
	starDesc = 4,
	id = 1,
	max = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	level = 2,
	starDesc = 1
}

function lua_hero_story_mode_v3a9_item_new_star.onLoad(json)
	lua_hero_story_mode_v3a9_item_new_star.configList, lua_hero_story_mode_v3a9_item_new_star.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a9_item_new_star
