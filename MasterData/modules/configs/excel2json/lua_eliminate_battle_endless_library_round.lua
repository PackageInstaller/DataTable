-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_endless_library_round.lua

module("modules.configs.excel2json.lua_eliminate_battle_endless_library_round", package.seeall)

local lua_eliminate_battle_endless_library_round = {}
local fields = {
	id = 1,
	endlessLibraryRound = 2,
	randomIds = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_eliminate_battle_endless_library_round.onLoad(json)
	lua_eliminate_battle_endless_library_round.configList, lua_eliminate_battle_endless_library_round.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_endless_library_round
