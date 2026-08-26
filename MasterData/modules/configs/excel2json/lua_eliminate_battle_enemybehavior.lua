-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_enemybehavior.lua

module("modules.configs.excel2json.lua_eliminate_battle_enemybehavior", package.seeall)

local lua_eliminate_battle_enemybehavior = {}
local fields = {
	prob3 = 9,
	list3 = 8,
	prob2 = 7,
	prob1 = 5,
	list1 = 4,
	round = 3,
	behavior = 2,
	list2 = 6,
	id = 1
}
local primaryKey = {
	"id",
	"behavior"
}
local mlStringKey = {}

function lua_eliminate_battle_enemybehavior.onLoad(json)
	lua_eliminate_battle_enemybehavior.configList, lua_eliminate_battle_enemybehavior.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_enemybehavior
