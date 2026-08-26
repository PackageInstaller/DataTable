-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item_new.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item_new", package.seeall)

local lua_hero_story_mode_v3a9_item_new = {}
local fields = {
	id = 1,
	item = 3,
	itemNew = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	itemNew = 1
}

function lua_hero_story_mode_v3a9_item_new.onLoad(json)
	lua_hero_story_mode_v3a9_item_new.configList, lua_hero_story_mode_v3a9_item_new.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a9_item_new
