-- chunkname: @modules/configs/excel2json/lua_v3a5_constant.lua

module("modules.configs.excel2json.lua_v3a5_constant", package.seeall)

local lua_v3a5_constant = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v3a5_constant.onLoad(json)
	lua_v3a5_constant.configList, lua_v3a5_constant.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v3a5_constant
