-- chunkname: @modules/configs/excel2json/lua_fight_ble_skill_2_crystal.lua

module("modules.configs.excel2json.lua_fight_ble_skill_2_crystal", package.seeall)

local lua_fight_ble_skill_2_crystal = {}
local fields = {
	crystal = 2,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}

function lua_fight_ble_skill_2_crystal.onLoad(json)
	lua_fight_ble_skill_2_crystal.configList, lua_fight_ble_skill_2_crystal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ble_skill_2_crystal
