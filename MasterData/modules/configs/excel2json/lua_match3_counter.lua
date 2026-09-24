-- chunkname: @modules/configs/excel2json/lua_match3_counter.lua

module("modules.configs.excel2json.lua_match3_counter", package.seeall)

local lua_match3_counter = {}
local fields = {
	multiplier = 4,
	defenderElementId = 3,
	id = 1,
	attackerElementId = 2,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_match3_counter.onLoad(json)
	lua_match3_counter.configList, lua_match3_counter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_counter
