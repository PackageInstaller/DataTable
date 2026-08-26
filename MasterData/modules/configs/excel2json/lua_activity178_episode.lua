-- chunkname: @modules/configs/excel2json/lua_activity178_episode.lua

module("modules.configs.excel2json.lua_activity178_episode", package.seeall)

local lua_activity178_episode = {}
local fields = {
	reward = 12,
	name = 4,
	condition2 = 10,
	type = 3,
	target = 11,
	shortDesc = 6,
	condition = 9,
	desc = 7,
	mapId = 8,
	id = 2,
	longDesc = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	longDesc = 2,
	name = 1,
	shortDesc = 3,
	desc = 4
}

function lua_activity178_episode.onLoad(json)
	lua_activity178_episode.configList, lua_activity178_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_episode
