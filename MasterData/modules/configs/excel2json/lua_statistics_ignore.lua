-- chunkname: @modules/configs/excel2json/lua_statistics_ignore.lua

module("modules.configs.excel2json.lua_statistics_ignore", package.seeall)

local lua_statistics_ignore = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_statistics_ignore.onLoad(json)
	lua_statistics_ignore.configList, lua_statistics_ignore.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_statistics_ignore
