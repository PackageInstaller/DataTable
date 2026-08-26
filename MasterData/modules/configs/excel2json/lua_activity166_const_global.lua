-- chunkname: @modules/configs/excel2json/lua_activity166_const_global.lua

module("modules.configs.excel2json.lua_activity166_const_global", package.seeall)

local lua_activity166_const_global = {}
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

function lua_activity166_const_global.onLoad(json)
	lua_activity166_const_global.configList, lua_activity166_const_global.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_const_global
