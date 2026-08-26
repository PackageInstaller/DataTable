-- chunkname: @modules/configs/excel2json/lua_cpu_level.lua

module("modules.configs.excel2json.lua_cpu_level", package.seeall)

local lua_cpu_level = {}
local fields = {
	level = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}

function lua_cpu_level.onLoad(json)
	lua_cpu_level.configList, lua_cpu_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_cpu_level
