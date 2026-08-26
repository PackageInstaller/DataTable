-- chunkname: @modules/configs/excel2json/lua_fight_ble_crystal_desc.lua

module("modules.configs.excel2json.lua_fight_ble_crystal_desc", package.seeall)

local lua_fight_ble_crystal_desc = {}
local fields = {
	id = 1,
	num = 2,
	tag = 4,
	desc = 3
}
local primaryKey = {
	"id",
	"num"
}
local mlStringKey = {
	tag = 2,
	desc = 1
}

function lua_fight_ble_crystal_desc.onLoad(json)
	lua_fight_ble_crystal_desc.configList, lua_fight_ble_crystal_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ble_crystal_desc
