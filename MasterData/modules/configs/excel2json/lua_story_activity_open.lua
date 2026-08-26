-- chunkname: @modules/configs/excel2json/lua_story_activity_open.lua

module("modules.configs.excel2json.lua_story_activity_open", package.seeall)

local lua_story_activity_open = {}
local fields = {
	part = 2,
	chapter = 1,
	labelRes = 5,
	titleEn = 4,
	title = 3,
	storyBg = 6
}
local primaryKey = {
	"chapter",
	"part"
}
local mlStringKey = {
	title = 1
}

function lua_story_activity_open.onLoad(json)
	lua_story_activity_open.configList, lua_story_activity_open.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_story_activity_open
