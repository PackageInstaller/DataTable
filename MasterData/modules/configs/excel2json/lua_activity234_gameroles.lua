-- chunkname: @modules/configs/excel2json/lua_activity234_gameroles.lua

module("modules.configs.excel2json.lua_activity234_gameroles", package.seeall)

local lua_activity234_gameroles = {}
local fields = {
	week = 1,
	gameroles = 2
}
local primaryKey = {
	"week"
}
local mlStringKey = {}

function lua_activity234_gameroles.onLoad(json)
	lua_activity234_gameroles.configList, lua_activity234_gameroles.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_gameroles
