-- chunkname: @modules/configs/excel2json/lua_survival_equip_found.lua

module("modules.configs.excel2json.lua_survival_equip_found", package.seeall)

local lua_survival_equip_found = {}
local fields = {
	icon2 = 6,
	name = 5,
	power = 11,
	desc1 = 3,
	value = 8,
	desc = 2,
	icon4 = 9,
	icon3 = 7,
	id = 1,
	icon = 4,
	level = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc1 = 2,
	name = 3,
	desc = 1
}

function lua_survival_equip_found.onLoad(json)
	lua_survival_equip_found.configList, lua_survival_equip_found.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_equip_found
