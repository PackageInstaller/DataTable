-- chunkname: @modules/configs/excel2json/lua_activity123_story.lua

module("modules.configs.excel2json.lua_activity123_story", package.seeall)

local lua_activity123_story = {}
local fields = {
	id = 1,
	picture = 5,
	subTitle = 6,
	storyId = 2,
	condition = 9,
	title = 3,
	content = 8,
	titleEn = 4,
	subContent = 7
}
local primaryKey = {
	"id",
	"storyId"
}
local mlStringKey = {
	subTitle = 3,
	titleEn = 2,
	subContent = 4,
	title = 1,
	content = 5
}

function lua_activity123_story.onLoad(json)
	lua_activity123_story.configList, lua_activity123_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_story
