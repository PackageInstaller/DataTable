-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_v3a4_base.lua

module("modules.configs.excel2json.lua_hero_story_mode_v3a4_base", package.seeall)

local lua_hero_story_mode_v3a4_base = {}
local fields = {
	finishAudio = 6,
	name = 2,
	pauseTime = 5,
	storyId = 3,
	id = 1,
	finishAudioTime = 7,
	preId = 8,
	gameId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_hero_story_mode_v3a4_base.onLoad(json)
	lua_hero_story_mode_v3a4_base.configList, lua_hero_story_mode_v3a4_base.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_mode_v3a4_base
