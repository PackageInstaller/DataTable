-- chunkname: @modules/configs/excel2json/lua_eliminate_episode.lua

module("modules.configs.excel2json.lua_eliminate_episode", package.seeall)

local lua_eliminate_episode = {}
local fields = {
	eliminateLevelId = 7,
	name = 2,
	chapterId = 5,
	preEpisode = 6,
	dialogueId = 9,
	posIndex = 4,
	levelPosition = 3,
	warChessId = 8,
	id = 1,
	aniPos = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_eliminate_episode.onLoad(json)
	lua_eliminate_episode.configList, lua_eliminate_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_episode
