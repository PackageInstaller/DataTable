-- chunkname: @modules/configs/excel2json/lua_activity176_episode.lua

module("modules.configs.excel2json.lua_activity176_episode", package.seeall)

local lua_activity176_episode = {}
local fields = {
	elementId = 3,
	activityId = 1,
	uiTemplate = 5,
	id = 2,
	target = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	target = 1
}

function lua_activity176_episode.onLoad(json)
	lua_activity176_episode.configList, lua_activity176_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity176_episode
