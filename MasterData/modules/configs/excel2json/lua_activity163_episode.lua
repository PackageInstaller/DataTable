-- chunkname: @modules/configs/excel2json/lua_activity163_episode.lua

module("modules.configs.excel2json.lua_activity163_episode", package.seeall)

local lua_activity163_episode = {}
local fields = {
	beforeStoryId = 5,
	name = 4,
	maxError = 10,
	promptsNum = 11,
	afterStoryId = 6,
	playerPieces = 12,
	opponentPieces = 13,
	episodeId = 2,
	evidenceId = 7,
	preEpisodeId = 3,
	failedId = 14,
	initialDialog = 8,
	activityId = 1,
	initialCluesIds = 9
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity163_episode.onLoad(json)
	lua_activity163_episode.configList, lua_activity163_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_episode
