-- chunkname: @modules/configs/excel2json/lua_critter_summon.lua

module("modules.configs.excel2json.lua_critter_summon", package.seeall)

local lua_critter_summon = {}
local fields = {
	cost = 2,
	serverSummon = 3,
	poolId = 1
}
local primaryKey = {
	"poolId"
}
local mlStringKey = {}

function lua_critter_summon.onLoad(json)
	lua_critter_summon.configList, lua_critter_summon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_summon
