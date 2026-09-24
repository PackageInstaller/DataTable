-- chunkname: @modules/configs/excel2json/lua_fight_hnj_cost.lua

module("modules.configs.excel2json.lua_fight_hnj_cost", package.seeall)

local lua_fight_hnj_cost = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_hnj_cost.onLoad(json)
	lua_fight_hnj_cost.configList, lua_fight_hnj_cost.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hnj_cost
