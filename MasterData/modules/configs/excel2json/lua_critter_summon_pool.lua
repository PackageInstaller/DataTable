-- chunkname: @modules/configs/excel2json/lua_critter_summon_pool.lua

module("modules.configs.excel2json.lua_critter_summon_pool", package.seeall)

local lua_critter_summon_pool = {}
local fields = {
	id = 1,
	critterIds = 3,
	rare = 2
}
local primaryKey = {
	"id",
	"rare"
}
local mlStringKey = {}

function lua_critter_summon_pool.onLoad(json)
	lua_critter_summon_pool.configList, lua_critter_summon_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_critter_summon_pool
