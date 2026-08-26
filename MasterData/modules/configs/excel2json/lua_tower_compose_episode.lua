-- chunkname: @modules/configs/excel2json/lua_tower_compose_episode.lua

module("modules.configs.excel2json.lua_tower_compose_episode", package.seeall)

local lua_tower_compose_episode = {}
local fields = {
	stageId = 3,
	name = 6,
	layerId = 2,
	episodeId = 8,
	unlockModIds = 9,
	nextLayerId = 4,
	unlock = 5,
	themeId = 1,
	plane = 7
}
local primaryKey = {
	"themeId",
	"layerId"
}
local mlStringKey = {
	name = 1
}

function lua_tower_compose_episode.onLoad(json)
	lua_tower_compose_episode.configList, lua_tower_compose_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_episode
