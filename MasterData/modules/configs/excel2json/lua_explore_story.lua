-- chunkname: @modules/configs/excel2json/lua_explore_story.lua

module("modules.configs.excel2json.lua_explore_story", package.seeall)

local lua_explore_story = {}
local fields = {
	type = 6,
	res = 5,
	chapterId = 1,
	id = 2,
	title = 3,
	content = 7,
	desc = 4
}
local primaryKey = {
	"chapterId",
	"id"
}
local mlStringKey = {
	title = 1,
	content = 3,
	desc = 2
}

function lua_explore_story.onLoad(json)
	lua_explore_story.configList, lua_explore_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_story
