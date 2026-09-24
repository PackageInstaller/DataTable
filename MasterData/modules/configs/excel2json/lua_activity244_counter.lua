-- chunkname: @modules/configs/excel2json/lua_activity244_counter.lua

module("modules.configs.excel2json.lua_activity244_counter", package.seeall)

local lua_activity244_counter = {}
local fields = {
	desc = 5,
	multiplier = 4,
	attackerCareer = 2,
	id = 1,
	defenderCareer = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity244_counter.onLoad(json)
	lua_activity244_counter.configList, lua_activity244_counter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_counter
