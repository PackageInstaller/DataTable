-- chunkname: @modules/configs/excel2json/lua_activity179_episode.lua

module("modules.configs.excel2json.lua_activity179_episode", package.seeall)

local lua_activity179_episode = {}
local fields = {
	name_En = 7,
	name = 6,
	orderId = 5,
	id = 2,
	storyAfter = 10,
	preEpisode = 3,
	beatId = 8,
	storyBefore = 9,
	episodeType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity179_episode.onLoad(json)
	lua_activity179_episode.configList, lua_activity179_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_episode
