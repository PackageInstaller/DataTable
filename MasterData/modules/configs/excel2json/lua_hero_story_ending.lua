-- chunkname: @modules/configs/excel2json/lua_hero_story_ending.lua

module("modules.configs.excel2json.lua_hero_story_ending", package.seeall)

local lua_hero_story_ending = {}
local fields = {
	id = 1,
	name = 4,
	storyStep = 3,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_story_ending.onLoad(json)
	lua_hero_story_ending.configList, lua_hero_story_ending.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_ending
