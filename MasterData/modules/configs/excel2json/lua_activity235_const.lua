-- chunkname: @modules/configs/excel2json/lua_activity235_const.lua

module("modules.configs.excel2json.lua_activity235_const", package.seeall)

local lua_activity235_const = {}
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

function lua_activity235_const.onLoad(json)
	lua_activity235_const.configList, lua_activity235_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity235_const
