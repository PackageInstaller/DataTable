-- chunkname: @modules/configs/excel2json/lua_243_episode.lua

module("modules.configs.excel2json.lua_243_episode", package.seeall)

local lua_243_episode = {}
local fields = {
	name = 5,
	preEpisodeId = 4,
	gameId = 6,
	clearBonus = 7,
	episodeType = 2,
	activityId = 3,
	episodeId = 1
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_243_episode.onLoad(json)
	lua_243_episode.configList, lua_243_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_243_episode
