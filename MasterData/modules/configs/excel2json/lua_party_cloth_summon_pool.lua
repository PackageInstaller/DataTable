-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon_pool.lua

module("modules.configs.excel2json.lua_party_cloth_summon_pool", package.seeall)

local lua_party_cloth_summon_pool = {}
local fields = {
	groupInitWeight = 3,
	groupChangeWeight = 4,
	rare = 2,
	poolId = 1
}
local primaryKey = {
	"poolId",
	"rare"
}
local mlStringKey = {}

function lua_party_cloth_summon_pool.onLoad(json)
	lua_party_cloth_summon_pool.configList, lua_party_cloth_summon_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_cloth_summon_pool
