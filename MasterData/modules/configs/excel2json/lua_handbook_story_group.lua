-- chunkname: @modules/configs/excel2json/lua_handbook_story_group.lua

module("modules.configs.excel2json.lua_handbook_story_group", package.seeall)

local lua_handbook_story_group = {}
local fields = {
	nameEn = 6,
	name = 5,
	time = 8,
	date = 7,
	episodeId = 4,
	image = 13,
	fragmentIdList = 12,
	storyChapterId = 3,
	storyIdList = 10,
	levelIdDict = 11,
	year = 9,
	id = 1,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_handbook_story_group.onLoad(json)
	lua_handbook_story_group.configList, lua_handbook_story_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_story_group
