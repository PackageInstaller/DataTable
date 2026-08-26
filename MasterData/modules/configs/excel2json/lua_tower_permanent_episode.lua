-- chunkname: @modules/configs/excel2json/lua_tower_permanent_episode.lua

module("modules.configs.excel2json.lua_tower_permanent_episode", package.seeall)

local lua_tower_permanent_episode = {}
local fields = {
	stageId = 2,
	firstReward = 6,
	index = 8,
	preLayerId = 3,
	isElite = 4,
	layerId = 1,
	episodeIds = 5,
	spReward = 7
}
local primaryKey = {
	"layerId"
}
local mlStringKey = {}

function lua_tower_permanent_episode.onLoad(json)
	lua_tower_permanent_episode.configList, lua_tower_permanent_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_permanent_episode
