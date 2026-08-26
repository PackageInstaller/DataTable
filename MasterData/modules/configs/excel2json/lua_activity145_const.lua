-- chunkname: @modules/configs/excel2json/lua_activity145_const.lua

module("modules.configs.excel2json.lua_activity145_const", package.seeall)

local lua_activity145_const = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity145_const.onLoad(json)
	lua_activity145_const.configList, lua_activity145_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity145_const
