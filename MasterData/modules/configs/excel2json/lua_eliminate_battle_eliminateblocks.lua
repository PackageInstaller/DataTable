-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_eliminateblocks.lua

module("modules.configs.excel2json.lua_eliminate_battle_eliminateblocks", package.seeall)

local lua_eliminate_battle_eliminateblocks = {}
local fields = {
	id = 1,
	damageRate = 3,
	healRate = 4,
	type = 2
}
local primaryKey = {
	"id",
	"type"
}
local mlStringKey = {}

function lua_eliminate_battle_eliminateblocks.onLoad(json)
	lua_eliminate_battle_eliminateblocks.configList, lua_eliminate_battle_eliminateblocks.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_eliminateblocks
