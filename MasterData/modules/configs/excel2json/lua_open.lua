-- chunkname: @modules/configs/excel2json/lua_open.lua

module("modules.configs.excel2json.lua_open", package.seeall)

local lua_open = {}
local fields = {
	isOnline = 3,
	name = 2,
	verifingHide = 11,
	verifingEpisodeId = 7,
	roomLevel = 13,
	playerLv = 4,
	dailyOpenTime = 14,
	episodeId = 5,
	elementId = 6,
	isAlwaysShowBtn = 8,
	bindActivityId = 12,
	id = 1,
	showInEpisode = 9,
	dec = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_open.onLoad(json)
	lua_open.configList, lua_open.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_open
