-- chunkname: @modules/configs/excel2json/lua_activity205_const.lua

module("modules.configs.excel2json.lua_activity205_const", package.seeall)

local lua_activity205_const = {}
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

function lua_activity205_const.onLoad(json)
	lua_activity205_const.configList, lua_activity205_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity205_const
