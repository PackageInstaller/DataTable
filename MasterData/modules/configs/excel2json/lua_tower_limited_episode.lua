-- chunkname: @modules/configs/excel2json/lua_tower_limited_episode.lua

module("modules.configs.excel2json.lua_tower_limited_episode", package.seeall)

local lua_tower_limited_episode = {}
local fields = {
	entrance = 5,
	season = 3,
	layerId = 1,
	difficulty = 2,
	episodeId = 4
}
local primaryKey = {
	"layerId",
	"difficulty"
}
local mlStringKey = {}

function lua_tower_limited_episode.onLoad(json)
	lua_tower_limited_episode.configList, lua_tower_limited_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_limited_episode
