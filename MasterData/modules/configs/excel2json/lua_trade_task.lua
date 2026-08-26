-- chunkname: @modules/configs/excel2json/lua_trade_task.lua

module("modules.configs.excel2json.lua_trade_task", package.seeall)

local lua_trade_task = {}
local fields = {
	sortId = 6,
	isOnline = 14,
	extraBonus = 12,
	speaker = 9,
	logtext = 10,
	icon = 11,
	listenerType = 3,
	desc = 2,
	listenerParam = 4,
	minType = 15,
	maxProgress = 5,
	jumpId = 13,
	id = 1,
	addRoomLog = 8,
	tradeLevel = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	minType = 2,
	desc = 1
}

function lua_trade_task.onLoad(json)
	lua_trade_task.configList, lua_trade_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trade_task
