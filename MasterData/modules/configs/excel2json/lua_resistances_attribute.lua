-- chunkname: @modules/configs/excel2json/lua_resistances_attribute.lua

module("modules.configs.excel2json.lua_resistances_attribute", package.seeall)

local lua_resistances_attribute = {}
local fields = {
	forbid = 7,
	sleep = 3,
	dizzy = 2,
	frozen = 5,
	petrified = 4,
	delExPointResilience = 14,
	delExPoint = 11,
	stressUp = 12,
	controlResilience = 13,
	charm = 10,
	stressUpResilience = 15,
	seal = 8,
	id = 1,
	disarm = 6,
	cantGetExskill = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_resistances_attribute.onLoad(json)
	lua_resistances_attribute.configList, lua_resistances_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_resistances_attribute
