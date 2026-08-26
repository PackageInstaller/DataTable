-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a2_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a2_item", package.seeall)

local lua_hero_story_mode_v3a2_item = {}
local fields = {
	unlock = 6,
	name = 2,
	id = 1,
	image = 3,
	sourceDesc = 5,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	sourceDesc = 3,
	desc = 2
}

function lua_hero_story_mode_v3a2_item.onLoad(json)
	lua_hero_story_mode_v3a2_item.configList, lua_hero_story_mode_v3a2_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a2_item
