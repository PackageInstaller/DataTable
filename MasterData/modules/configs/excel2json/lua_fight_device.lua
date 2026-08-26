-- chunkname: @modules/configs/excel2json/lua_fight_device.lua

module("modules.configs.excel2json.lua_fight_device", package.seeall)

local lua_fight_device = {}
local fields = {
	powerSkill = 2,
	specialPowerSkill = 3,
	skill1 = 4,
	skill2 = 5,
	id = 1,
	uniqueSkill = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_device.onLoad(json)
	lua_fight_device.configList, lua_fight_device.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_device
