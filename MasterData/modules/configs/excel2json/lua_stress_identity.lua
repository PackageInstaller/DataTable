-- chunkname: @modules/configs/excel2json/lua_stress_identity.lua

module("modules.configs.excel2json.lua_stress_identity", package.seeall)

local lua_stress_identity = {}
local fields = {
	param = 6,
	effect = 5,
	name = 2,
	typeParam = 4,
	isNoShow = 7,
	desc = 8,
	id = 1,
	uiType = 9,
	identity = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_stress_identity.onLoad(json)
	lua_stress_identity.configList, lua_stress_identity.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stress_identity
