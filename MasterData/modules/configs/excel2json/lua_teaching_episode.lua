-- chunkname: @modules/configs/excel2json/lua_teaching_episode.lua

module("modules.configs.excel2json.lua_teaching_episode", package.seeall)

local lua_teaching_episode = {}
local fields = {
	teaching = 2,
	battleTasks = 5,
	taskDetail = 6,
	type = 4,
	id = 1,
	preEpisode = 7,
	detail = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskDetail = 2,
	detail = 1
}

function lua_teaching_episode.onLoad(json)
	lua_teaching_episode.configList, lua_teaching_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_teaching_episode
