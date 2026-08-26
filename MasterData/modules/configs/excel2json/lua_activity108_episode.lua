-- chunkname: @modules/configs/excel2json/lua_activity108_episode.lua

module("modules.configs.excel2json.lua_activity108_episode", package.seeall)

local lua_activity108_episode = {}
local fields = {
	period = 5,
	mapId = 2,
	actpoint = 6,
	epilogue = 8,
	day = 4,
	showBoss = 10,
	res = 3,
	id = 1,
	showExhibits = 9,
	preface = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	epilogue = 2,
	preface = 1
}

function lua_activity108_episode.onLoad(json)
	lua_activity108_episode.configList, lua_activity108_episode.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_episode
