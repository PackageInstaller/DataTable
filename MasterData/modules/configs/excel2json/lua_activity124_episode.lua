-- chunkname: @modules/configs/excel2json/lua_activity124_episode.lua

module("modules.configs.excel2json.lua_activity124_episode", package.seeall)

local lua_activity124_episode = {}
local fields = {
	openDay = 4,
	name = 6,
	firstBonus = 5,
	mapId = 7,
	preEpisode = 3,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity124_episode.onLoad(json)
	lua_activity124_episode.configList, lua_activity124_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity124_episode
