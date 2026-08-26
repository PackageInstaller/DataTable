-- chunkname: @modules/configs/excel2json/lua_equip_break_cost.lua

module("modules.configs.excel2json.lua_equip_break_cost", package.seeall)

local lua_equip_break_cost = {}
local fields = {
	cost = 4,
	scoreCost = 5,
	breakLevel = 2,
	rare = 1,
	level = 3
}
local primaryKey = {
	"rare",
	"breakLevel"
}
local mlStringKey = {}

function lua_equip_break_cost.onLoad(json)
	lua_equip_break_cost.configList, lua_equip_break_cost.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_break_cost
