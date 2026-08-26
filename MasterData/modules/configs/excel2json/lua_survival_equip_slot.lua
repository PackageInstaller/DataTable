-- chunkname: @modules/configs/excel2json/lua_survival_equip_slot.lua

module("modules.configs.excel2json.lua_survival_equip_slot", package.seeall)

local lua_survival_equip_slot = {}
local fields = {
	effect1 = 10,
	slot3 = 4,
	slot6 = 7,
	slot1 = 2,
	slot4 = 5,
	slot7 = 8,
	slot2 = 3,
	id = 1,
	slot5 = 6,
	slot8 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_equip_slot.onLoad(json)
	lua_survival_equip_slot.configList, lua_survival_equip_slot.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_equip_slot
