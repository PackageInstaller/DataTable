-- chunkname: @modules/configs/excel2json/lua_survival_disaster.lua

module("modules.configs.excel2json.lua_survival_disaster", package.seeall)

local lua_survival_disaster = {}
local fields = {
	block = 2,
	name = 3,
	disasterDesc = 5,
	level = 6,
	id = 1,
	recommend = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	disasterDesc = 2,
	name = 1
}

function lua_survival_disaster.onLoad(json)
	lua_survival_disaster.configList, lua_survival_disaster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_disaster
