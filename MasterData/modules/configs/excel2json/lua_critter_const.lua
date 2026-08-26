-- chunkname: @modules/configs/excel2json/lua_critter_const.lua

module("modules.configs.excel2json.lua_critter_const", package.seeall)

local lua_critter_const = {}
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

function lua_critter_const.onLoad(json)
	lua_critter_const.configList, lua_critter_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_const
