-- chunkname: @modules/configs/excel2json/lua_viewhelp.lua

module("modules.configs.excel2json.lua_viewhelp", package.seeall)

local lua_viewhelp = {}
local fields = {
	id = 1,
	page = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_viewhelp.onLoad(json)
	lua_viewhelp.configList, lua_viewhelp.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_viewhelp
