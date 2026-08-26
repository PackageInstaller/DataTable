-- chunkname: @modules/configs/excel2json/lua_tower_compose_point_round.lua

module("modules.configs.excel2json.lua_tower_compose_point_round", package.seeall)

local lua_tower_compose_point_round = {}
local fields = {
	round = 1,
	bossPointAdd = 2
}
local primaryKey = {
	"round"
}
local mlStringKey = {}

function lua_tower_compose_point_round.onLoad(json)
	lua_tower_compose_point_round.configList, lua_tower_compose_point_round.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_point_round
