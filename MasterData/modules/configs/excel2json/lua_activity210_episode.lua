-- chunkname: @modules/configs/excel2json/lua_activity210_episode.lua

module("modules.configs.excel2json.lua_activity210_episode", package.seeall)

local lua_activity210_episode = {}
local fields = {
	storyBefore = 6,
	name = 5,
	preEpisodeBranchId = 4,
	type = 10,
	guideId = 11,
	storyClear = 8,
	episodeId = 2,
	disactiveEpisodeIds = 9,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 7
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}

function lua_activity210_episode.onLoad(json)
	lua_activity210_episode.configList, lua_activity210_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity210_episode
