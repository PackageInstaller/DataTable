-- chunkname: @modules/configs/excel2json/lua_activity191_match_rank.lua

module("modules.configs.excel2json.lua_activity191_match_rank", package.seeall)

local lua_activity191_match_rank = {}
local fields = {
	rank = 1,
	fightLevel = 2
}
local primaryKey = {
	"rank"
}
local mlStringKey = {}

function lua_activity191_match_rank.onLoad(json)
	lua_activity191_match_rank.configList, lua_activity191_match_rank.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_match_rank
