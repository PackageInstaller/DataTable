-- chunkname: @modules/configs/excel2json/lua_activity126_episode_daily.lua

module("modules.configs.excel2json.lua_activity126_episode_daily", package.seeall)

local lua_activity126_episode_daily = {}
local fields = {
	id = 1,
	activityId = 3,
	refreshDay = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity126_episode_daily.onLoad(json)
	lua_activity126_episode_daily.configList, lua_activity126_episode_daily.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity126_episode_daily
