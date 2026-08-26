-- chunkname: @modules/configs/excel2json/lua_equip_strengthen_cost.lua

module("modules.configs.excel2json.lua_equip_strengthen_cost", package.seeall)

local lua_equip_strengthen_cost = {}
local fields = {
	scoreCost = 4,
	attributeRate = 5,
	exp = 3,
	rare = 1,
	level = 2
}
local primaryKey = {
	"rare",
	"level"
}
local mlStringKey = {}

function lua_equip_strengthen_cost.onLoad(json)
	lua_equip_strengthen_cost.configList, lua_equip_strengthen_cost.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_strengthen_cost
