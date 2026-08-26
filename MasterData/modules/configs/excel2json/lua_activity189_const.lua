-- chunkname: @modules/configs/excel2json/lua_activity189_const.lua

module("modules.configs.excel2json.lua_activity189_const", package.seeall)

local lua_activity189_const = {}
local fields = {
	id = 1,
	numValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity189_const.onLoad(json)
	lua_activity189_const.configList, lua_activity189_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_const
