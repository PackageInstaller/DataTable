-- chunkname: @modules/configs/excel2json/lua_hero_story_score.lua

module("modules.configs.excel2json.lua_hero_story_score", package.seeall)

local lua_hero_story_score = {}
local fields = {
	id = 1,
	wave = 3,
	score = 4,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_story_score.onLoad(json)
	lua_hero_story_score.configList, lua_hero_story_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_score
