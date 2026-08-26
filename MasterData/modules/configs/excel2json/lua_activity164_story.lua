-- chunkname: @modules/configs/excel2json/lua_activity164_story.lua

module("modules.configs.excel2json.lua_activity164_story", package.seeall)

local lua_activity164_story = {}
local fields = {
	bgPath = 9,
	name = 5,
	needbg = 8,
	nameen = 6,
	episodeId = 2,
	id = 4,
	icon = 7,
	activityId = 1,
	order = 3
}
local primaryKey = {
	"activityId",
	"episodeId",
	"order"
}
local mlStringKey = {
	name = 1
}

function lua_activity164_story.onLoad(json)
	lua_activity164_story.configList, lua_activity164_story.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity164_story
