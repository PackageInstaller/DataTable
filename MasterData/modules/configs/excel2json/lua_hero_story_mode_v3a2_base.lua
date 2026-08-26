-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a2_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a2_base", package.seeall)

local lua_hero_story_mode_v3a2_base = {}
local fields = {
	id = 1,
	unlockItem = 4,
	preId = 3,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_story_mode_v3a2_base.onLoad(json)
	lua_hero_story_mode_v3a2_base.configList, lua_hero_story_mode_v3a2_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a2_base
