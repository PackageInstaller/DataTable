-- chunkname: @modules/configs/excel2json/lua_tower_boss_episode.lua

module("modules.configs.excel2json.lua_tower_boss_episode", package.seeall)

local lua_tower_boss_episode = {}
local fields = {
	layerId = 2,
	firstReward = 7,
	bossLevel = 6,
	preLayerId = 3,
	episodeId = 5,
	openRound = 4,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"layerId"
}
local mlStringKey = {}

function lua_tower_boss_episode.onLoad(json)
	lua_tower_boss_episode.configList, lua_tower_boss_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_boss_episode
