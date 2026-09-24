-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_question.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_question", package.seeall)

local lua_hero_story_mode_v4a0_question = {}
local fields = {
	group = 2,
	title = 3,
	content = 4,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}

function lua_hero_story_mode_v4a0_question.onLoad(json)
	lua_hero_story_mode_v4a0_question.configList, lua_hero_story_mode_v4a0_question.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v4a0_question
