-- chunkname: @modules/configs/excel2json/lua_equip_const.lua

module("modules.configs.excel2json.lua_equip_const", package.seeall)

local lua_equip_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_equip_const.onLoad(json)
	lua_equip_const.configList, lua_equip_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_const
