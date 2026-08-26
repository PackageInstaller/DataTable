-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_fugaoren_story.lua

module("modules.configs.excel2json.lua_hero_story_mode_fugaoren_story", package.seeall)

local lua_hero_story_mode_fugaoren_story = {}
local fields = {
	baseId = 2,
	id = 1,
	preId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_story_mode_fugaoren_story.onLoad(json)
	lua_hero_story_mode_fugaoren_story.configList, lua_hero_story_mode_fugaoren_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_fugaoren_story
