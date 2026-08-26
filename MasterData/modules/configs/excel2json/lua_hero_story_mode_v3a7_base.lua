-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a7_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a7_base", package.seeall)

local lua_hero_story_mode_v3a7_base = {}
local fields = {
	mapRotate = 4,
	spDesc = 5,
	preId = 3,
	storyId = 2,
	id = 1,
	spDescPic = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_hero_story_mode_v3a7_base.onLoad(json)
	lua_hero_story_mode_v3a7_base.configList, lua_hero_story_mode_v3a7_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a7_base
