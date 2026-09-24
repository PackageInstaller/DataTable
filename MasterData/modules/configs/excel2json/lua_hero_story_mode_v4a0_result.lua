-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v4a0_result.lua

module("modules.configs.excel2json.lua_hero_story_mode_v4a0_result", package.seeall)

local lua_hero_story_mode_v4a0_result = {}
local fields = {
	desc2 = 4,
	desc1 = 3,
	id = 1,
	title = 2,
	score1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	title = 1,
	desc1 = 2
}

function lua_hero_story_mode_v4a0_result.onLoad(json)
	lua_hero_story_mode_v4a0_result.configList, lua_hero_story_mode_v4a0_result.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v4a0_result
