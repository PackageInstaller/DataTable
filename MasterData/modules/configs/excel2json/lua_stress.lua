-- chunkname: @modules/configs/excel2json/lua_stress.lua

module("modules.configs.excel2json.lua_stress", package.seeall)

local lua_stress = {}
local fields = {
	desc = 3,
	pressParam = 7,
	rule = 8,
	type = 6,
	id = 1,
	title = 4,
	condition = 5,
	identity = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_stress.onLoad(json)
	lua_stress.configList, lua_stress.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_stress
