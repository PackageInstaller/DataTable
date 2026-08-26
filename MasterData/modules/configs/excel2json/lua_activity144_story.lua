-- chunkname: @modules/configs/excel2json/lua_activity144_story.lua

module("modules.configs.excel2json.lua_activity144_story", package.seeall)

local lua_activity144_story = {}
local fields = {
	titleen = 5,
	name = 3,
	order = 8,
	nameen = 4,
	id = 2,
	icon = 7,
	activityId = 1,
	episodeId = 6
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity144_story.onLoad(json)
	lua_activity144_story.configList, lua_activity144_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_story
