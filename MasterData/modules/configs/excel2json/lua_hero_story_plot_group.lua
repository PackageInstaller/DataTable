-- chunkname: @modules/configs/excel2json/lua_hero_story_plot_group.lua

module("modules.configs.excel2json.lua_hero_story_plot_group", package.seeall)

local lua_hero_story_plot_group = {}
local fields = {
	storyPic = 9,
	branch = 11,
	storyNameEn = 4,
	storyId = 2,
	preId = 10,
	time = 5,
	date = 12,
	place = 6,
	roleName = 8,
	weather = 7,
	storyName = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	roleName = 3,
	place = 2,
	storyName = 1
}

function lua_hero_story_plot_group.onLoad(json)
	lua_hero_story_plot_group.configList, lua_hero_story_plot_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero_story_plot_group
