-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon.lua

module("modules.configs.excel2json.lua_party_cloth_summon", package.seeall)

local lua_party_cloth_summon = {}
local fields = {
	cost = 4,
	changeWeight = 3,
	initWeight = 2,
	activityId = 5,
	poolId = 1
}
local primaryKey = {
	"poolId"
}
local mlStringKey = {}

function lua_party_cloth_summon.onLoad(json)
	lua_party_cloth_summon.configList, lua_party_cloth_summon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_cloth_summon
