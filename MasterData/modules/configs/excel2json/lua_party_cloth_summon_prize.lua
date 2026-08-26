-- chunkname: @modules/configs/excel2json/lua_party_cloth_summon_prize.lua

module("modules.configs.excel2json.lua_party_cloth_summon_prize", package.seeall)

local lua_party_cloth_summon_prize = {}
local fields = {
	groupId = 1,
	prizeParams = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}

function lua_party_cloth_summon_prize.onLoad(json)
	lua_party_cloth_summon_prize.configList, lua_party_cloth_summon_prize.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_cloth_summon_prize
