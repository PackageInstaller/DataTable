-- chunkname: @modules/configs/excel2json/lua_activity246_const.lua

module("modules.configs.excel2json.lua_activity246_const", package.seeall)

local lua_activity246_const = {}
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

function lua_activity246_const.onLoad(json)
	lua_activity246_const.configList, lua_activity246_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity246_const
