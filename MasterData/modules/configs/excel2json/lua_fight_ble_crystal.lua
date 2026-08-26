-- chunkname: @modules/configs/excel2json/lua_fight_ble_crystal.lua

module("modules.configs.excel2json.lua_fight_ble_crystal", package.seeall)

local lua_fight_ble_crystal = {}
local fields = {
	id = 1,
	name = 2,
	smallIcon = 5,
	nameColor = 6,
	iconBg = 4,
	icon = 3,
	cardTimeline = 7,
	skill3Timeline = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_fight_ble_crystal.onLoad(json)
	lua_fight_ble_crystal.configList, lua_fight_ble_crystal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ble_crystal
