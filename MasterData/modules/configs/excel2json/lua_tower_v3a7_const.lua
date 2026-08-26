-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_const.lua

module("modules.configs.excel2json.lua_tower_v3a7_const", package.seeall)

local lua_tower_v3a7_const = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_tower_v3a7_const.onLoad(json)
	lua_tower_v3a7_const.configList, lua_tower_v3a7_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_v3a7_const
