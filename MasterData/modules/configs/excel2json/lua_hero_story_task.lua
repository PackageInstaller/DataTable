-- chunkname: @modules/configs/excel2json/lua_hero_story_task.lua

module("modules.configs.excel2json.lua_hero_story_task", package.seeall)

local lua_hero_story_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	storyId = 2,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 10,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_hero_story_task.onLoad(json)
	lua_hero_story_task.configList, lua_hero_story_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_task
