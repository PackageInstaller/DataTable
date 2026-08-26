-- chunkname: @modules/configs/excel2json/lua_fight_skin_dead_performance.lua

module("modules.configs.excel2json.lua_fight_skin_dead_performance", package.seeall)

local lua_fight_skin_dead_performance = {}
local fields = {
	id = 1,
	actType5 = 10,
	actType1 = 2,
	actParam8 = 17,
	actParam5 = 11,
	actType2 = 4,
	actParam1 = 3,
	actType3 = 6,
	actType6 = 12,
	actParam6 = 13,
	actType4 = 8,
	actType7 = 14,
	actParam7 = 15,
	actParam2 = 5,
	actType8 = 16,
	actParam4 = 9,
	actParam3 = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_skin_dead_performance.onLoad(json)
	lua_fight_skin_dead_performance.configList, lua_fight_skin_dead_performance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_skin_dead_performance
