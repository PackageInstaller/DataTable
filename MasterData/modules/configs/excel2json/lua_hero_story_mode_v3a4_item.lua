-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_item", package.seeall)

local lua_hero_story_mode_v3a4_item = {}
local fields = {
	itemId = 1,
	name = 3,
	point = 2,
	resource = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	name = 1
}

function lua_hero_story_mode_v3a4_item.onLoad(json)
	lua_hero_story_mode_v3a4_item.configList, lua_hero_story_mode_v3a4_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a4_item
