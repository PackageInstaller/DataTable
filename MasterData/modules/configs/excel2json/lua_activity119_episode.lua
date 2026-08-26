-- chunkname: @modules/configs/excel2json/lua_activity119_episode.lua

module("modules.configs.excel2json.lua_activity119_episode", package.seeall)

local lua_activity119_episode = {}
local fields = {
	openDay = 5,
	name = 3,
	tabId = 4,
	id = 2,
	icon = 6,
	activityId = 1,
	des = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_activity119_episode.onLoad(json)
	lua_activity119_episode.configList, lua_activity119_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity119_episode
