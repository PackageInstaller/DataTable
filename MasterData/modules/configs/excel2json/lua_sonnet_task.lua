-- chunkname: @modules/configs/excel2json/lua_sonnet_task.lua

module("modules.configs.excel2json.lua_sonnet_task", package.seeall)

local lua_sonnet_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	chapterId = 2,
	episodeId = 10,
	listenerType = 7,
	isGrandPrize = 13,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}

function lua_sonnet_task.onLoad(json)
	lua_sonnet_task.configList, lua_sonnet_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sonnet_task
