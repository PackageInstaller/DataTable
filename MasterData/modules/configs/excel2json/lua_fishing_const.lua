-- chunkname: @modules/configs/excel2json/lua_fishing_const.lua

module("modules.configs.excel2json.lua_fishing_const", package.seeall)

local lua_fishing_const = {}
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

function lua_fishing_const.onLoad(json)
	lua_fishing_const.configList, lua_fishing_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fishing_const
