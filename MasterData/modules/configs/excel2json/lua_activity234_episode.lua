-- chunkname: @modules/configs/excel2json/lua_activity234_episode.lua

module("modules.configs.excel2json.lua_activity234_episode", package.seeall)

local lua_activity234_episode = {}
local fields = {
	id = 1,
	layout = 2,
	name = 4,
	lineCount = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity234_episode.onLoad(json)
	lua_activity234_episode.configList, lua_activity234_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_episode
