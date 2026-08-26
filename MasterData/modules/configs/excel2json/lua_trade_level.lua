-- chunkname: @modules/configs/excel2json/lua_trade_level.lua

module("modules.configs.excel2json.lua_trade_level", package.seeall)

local lua_trade_level = {}
local fields = {
	maxRestBuildingNum = 2,
	maxTrainSlotCount = 8,
	jobCard = 6,
	job = 5,
	dimension = 4,
	levelUpNeedTask = 7,
	trainsRoundCount = 9,
	unlockId = 10,
	addBlockMax = 3,
	silenceBonus = 11,
	bonus = 12,
	taskName = 13,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	dimension = 1,
	taskName = 3,
	job = 2
}

function lua_trade_level.onLoad(json)
	lua_trade_level.configList, lua_trade_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_trade_level
