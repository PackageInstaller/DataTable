-- chunkname: @modules/configs/excel2json/lua_activity149_episode.lua

module("modules.configs.excel2json.lua_activity149_episode", package.seeall)

local lua_activity149_episode = {}
local fields = {
	order = 4,
	multi = 5,
	firstPassScore = 6,
	id = 1,
	effectCondition = 7,
	activityId = 2,
	episodeId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity149_episode.onLoad(json)
	lua_activity149_episode.configList, lua_activity149_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity149_episode
