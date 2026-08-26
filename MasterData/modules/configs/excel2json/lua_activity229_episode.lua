-- chunkname: @modules/configs/excel2json/lua_activity229_episode.lua

module("modules.configs.excel2json.lua_activity229_episode", package.seeall)

local lua_activity229_episode = {}
local fields = {
	careerPrefer = 4,
	teamRecommend = 5,
	optionalSkills = 6,
	stage = 2,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {}

function lua_activity229_episode.onLoad(json)
	lua_activity229_episode.configList, lua_activity229_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity229_episode
