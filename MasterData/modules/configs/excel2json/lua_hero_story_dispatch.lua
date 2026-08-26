-- chunkname: @modules/configs/excel2json/lua_hero_story_dispatch.lua

module("modules.configs.excel2json.lua_hero_story_dispatch", package.seeall)

local lua_hero_story_dispatch = {}
local fields = {
	scoreReward = 9,
	name = 4,
	count = 8,
	type = 2,
	time = 10,
	effect = 12,
	effectDesc = 13,
	desc = 5,
	unlockEpisodeId = 14,
	talkIds = 15,
	heroStoryId = 3,
	consume = 7,
	id = 1,
	effectCondition = 11,
	completeDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 4,
	name = 1,
	completeDesc = 3,
	desc = 2
}

function lua_hero_story_dispatch.onLoad(json)
	lua_hero_story_dispatch.configList, lua_hero_story_dispatch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_dispatch
