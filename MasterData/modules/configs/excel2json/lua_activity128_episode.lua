-- chunkname: @modules/configs/excel2json/lua_activity128_episode.lua

module("modules.configs.excel2json.lua_activity128_episode", package.seeall)

local lua_activity128_episode = {}
local fields = {
	openDay = 9,
	enhanceRole = 5,
	recommendLevelDesc = 8,
	type = 4,
	episodeId = 6,
	evaluate = 10,
	desc = 7,
	stage = 2,
	activityId = 1,
	layer = 3
}
local primaryKey = {
	"activityId",
	"stage",
	"layer"
}
local mlStringKey = {
	desc = 1
}

function lua_activity128_episode.onLoad(json)
	lua_activity128_episode.configList, lua_activity128_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_episode
