-- chunkname: @modules/configs/excel2json/lua_activity121_story.lua

module("modules.configs.excel2json.lua_activity121_story", package.seeall)

local lua_activity121_story = {}
local fields = {
	noteIds = 6,
	name = 3,
	clueIds = 5,
	bonus = 7,
	id = 2,
	icon = 8,
	activityId = 1,
	episodeId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity121_story.onLoad(json)
	lua_activity121_story.configList, lua_activity121_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity121_story
