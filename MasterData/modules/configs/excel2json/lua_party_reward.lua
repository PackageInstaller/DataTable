-- chunkname: @modules/configs/excel2json/lua_party_reward.lua

module("modules.configs.excel2json.lua_party_reward", package.seeall)

local lua_party_reward = {}
local fields = {
	rank = 1,
	reward = 2
}
local primaryKey = {
	"rank"
}
local mlStringKey = {}

function lua_party_reward.onLoad(json)
	lua_party_reward.configList, lua_party_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_reward
