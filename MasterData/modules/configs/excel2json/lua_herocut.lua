-- chunkname: @modules/configs/excel2json/lua_herocut.lua

module("modules.configs.excel2json.lua_herocut", package.seeall)

local lua_herocut = {}
local fields = {
	id = 1,
	cutName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_herocut.onLoad(json)
	lua_herocut.configList, lua_herocut.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_herocut
