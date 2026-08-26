-- chunkname: @modules/configs/excel2json/lua_hero_story_plot.lua

module("modules.configs.excel2json.lua_hero_story_plot", package.seeall)

local lua_hero_story_plot = {}
local fields = {
	addControl = 8,
	name = 5,
	param = 4,
	type = 3,
	controlParam = 10,
	desc = 6,
	controlDelay = 9,
	pause = 7,
	id = 1,
	storygroup = 2,
	level = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_hero_story_plot.onLoad(json)
	lua_hero_story_plot.configList, lua_hero_story_plot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_plot
