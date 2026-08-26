-- chunkname: @modules/configs/excel2json/lua_partygame_snatchterritory.lua

module("modules.configs.excel2json.lua_partygame_snatchterritory", package.seeall)

local lua_partygame_snatchterritory = {}
local fields = {
	playerNum = 2,
	numMax = 3,
	id = 1,
	interval = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_partygame_snatchterritory.onLoad(json)
	lua_partygame_snatchterritory.configList, lua_partygame_snatchterritory.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_snatchterritory
