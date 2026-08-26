-- chunkname: @modules/configs/excel2json/lua_simple_polarization.lua

module("modules.configs.excel2json.lua_simple_polarization", package.seeall)

local lua_simple_polarization = {}
local fields = {
	desc = 3,
	name = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_simple_polarization.onLoad(json)
	lua_simple_polarization.configList, lua_simple_polarization.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_simple_polarization
