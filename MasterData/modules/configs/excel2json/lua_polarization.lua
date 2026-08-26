-- chunkname: @modules/configs/excel2json/lua_polarization.lua

module("modules.configs.excel2json.lua_polarization", package.seeall)

local lua_polarization = {}
local fields = {
	type = 2,
	name = 3,
	desc = 4,
	level = 1
}
local primaryKey = {
	"level",
	"type"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_polarization.onLoad(json)
	lua_polarization.configList, lua_polarization.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_polarization
