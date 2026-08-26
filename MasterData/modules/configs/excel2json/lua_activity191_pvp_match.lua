-- chunkname: @modules/configs/excel2json/lua_activity191_pvp_match.lua

module("modules.configs.excel2json.lua_activity191_pvp_match", package.seeall)

local lua_activity191_pvp_match = {}
local fields = {
	rewardView = 2,
	attribute = 4,
	autoRewardView = 3,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_activity191_pvp_match.onLoad(json)
	lua_activity191_pvp_match.configList, lua_activity191_pvp_match.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_pvp_match
