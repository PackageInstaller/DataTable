-- chunkname: @modules/configs/excel2json/lua_handbook_equip.lua

module("modules.configs.excel2json.lua_handbook_equip", package.seeall)

local lua_handbook_equip = {}
local fields = {
	id = 1,
	equipId = 3,
	desc = 4,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_handbook_equip.onLoad(json)
	lua_handbook_equip.configList, lua_handbook_equip.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_equip
