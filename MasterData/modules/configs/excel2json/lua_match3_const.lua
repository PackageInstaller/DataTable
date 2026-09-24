-- chunkname: @modules/configs/excel2json/lua_match3_const.lua

module("modules.configs.excel2json.lua_match3_const", package.seeall)

local lua_match3_const = {}
local fields = {
	id = 1,
	constKey = 2,
	value = 3,
	value2 = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_match3_const.onLoad(json)
	lua_match3_const.configList, lua_match3_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_const
