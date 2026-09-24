-- chunkname: @modules/configs/excel2json/lua_fight_ble_crystal.lua

module("modules.configs.excel2json.lua_fight_ble_crystal", package.seeall)

local lua_fight_ble_crystal = {}
local fields = {
	smallIcon = 6,
	name = 3,
	iconBg = 5,
	cardTimeline = 8,
	skin = 1,
	nameColor = 7,
	id = 2,
	icon = 4,
	skill3Timeline = 9
}
local primaryKey = {
	"skin",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_fight_ble_crystal.onLoad(json)
	lua_fight_ble_crystal.configList, lua_fight_ble_crystal.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ble_crystal
