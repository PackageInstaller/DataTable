-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a9_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a9_base", package.seeall)

local lua_hero_story_mode_v3a9_base = {}
local fields = {
	name = 2,
	preId = 3,
	storyId = 4,
	id = 1,
	pic = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_story_mode_v3a9_base.onLoad(json)
	lua_hero_story_mode_v3a9_base.configList, lua_hero_story_mode_v3a9_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a9_base
