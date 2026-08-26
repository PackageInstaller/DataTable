-- chunkname: @modules/configs/excel2json/lua_udimo_info.lua

module("modules.configs.excel2json.lua_udimo_info", package.seeall)

local lua_udimo_info = {}
local fields = {
	id = 1,
	langId = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_udimo_info.onLoad(json)
	lua_udimo_info.configList, lua_udimo_info.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_udimo_info
