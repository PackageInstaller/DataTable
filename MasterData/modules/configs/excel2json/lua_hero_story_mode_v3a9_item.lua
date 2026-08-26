-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_item.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_item", package.seeall)

local lua_hero_story_mode_v3a9_item = {}
local fields = {
	storyPic = 8,
	unlock = 6,
	itemName = 4,
	type = 3,
	id = 1,
	group = 2,
	sourceDesc = 7,
	itemDesc1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	sourceDesc = 3,
	itemName = 1,
	itemDesc1 = 2
}

function lua_hero_story_mode_v3a9_item.onLoad(json)
	lua_hero_story_mode_v3a9_item.configList, lua_hero_story_mode_v3a9_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a9_item
