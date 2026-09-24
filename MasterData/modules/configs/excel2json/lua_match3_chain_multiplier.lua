-- chunkname: @modules/configs/excel2json/lua_match3_chain_multiplier.lua

module("modules.configs.excel2json.lua_match3_chain_multiplier", package.seeall)

local lua_match3_chain_multiplier = {}
local fields = {
	chainMin = 2,
	multiplier = 4,
	chainMax = 3,
	id = 1,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_match3_chain_multiplier.onLoad(json)
	lua_match3_chain_multiplier.configList, lua_match3_chain_multiplier.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_match3_chain_multiplier
