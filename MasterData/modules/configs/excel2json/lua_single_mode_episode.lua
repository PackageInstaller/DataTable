-- chunkname: @modules/configs/excel2json/lua_single_mode_episode.lua

module("modules.configs.excel2json.lua_single_mode_episode", package.seeall)

local lua_single_mode_episode = {}
local fields = {
	openDay = 3,
	episodeId2Level = 4,
	activityId = 2,
	chapterId = 1
}
local primaryKey = {
	"chapterId"
}
local mlStringKey = {}

function lua_single_mode_episode.onLoad(json)
	lua_single_mode_episode.configList, lua_single_mode_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_single_mode_episode
