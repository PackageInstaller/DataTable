-- chunkname: @modules/configs/excel2json/lua_activity244_episode.lua

module("modules.configs.excel2json.lua_activity244_episode", package.seeall)

local lua_activity244_episode = {}
local fields = {
	episodeImage = 8,
	firstBonus = 6,
	recCareer = 9,
	chapterId = 2,
	levelName = 3,
	preEpisode = 4,
	matchLevelId = 5,
	isHard = 10,
	id = 1,
	bonus = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	levelName = 1
}

function lua_activity244_episode.onLoad(json)
	lua_activity244_episode.configList, lua_activity244_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_episode
