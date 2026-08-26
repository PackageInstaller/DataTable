-- chunkname: @modules/configs/excel2json/lua_activity122_story.lua

module("modules.configs.excel2json.lua_activity122_story", package.seeall)

local lua_activity122_story = {}
local fields = {
	bgPath = 9,
	name = 3,
	needbg = 8,
	nameen = 4,
	episodeId = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	order = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity122_story.onLoad(json)
	lua_activity122_story.configList, lua_activity122_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity122_story
