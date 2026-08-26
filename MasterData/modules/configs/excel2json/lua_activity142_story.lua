-- chunkname: @modules/configs/excel2json/lua_activity142_story.lua

module("modules.configs.excel2json.lua_activity142_story", package.seeall)

local lua_activity142_story = {}
local fields = {
	order = 7,
	name = 3,
	nameen = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	episodeId = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity142_story.onLoad(json)
	lua_activity142_story.configList, lua_activity142_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity142_story
