-- chunkname: @modules/configs/excel2json/lua_siege_battle_word.lua

module("modules.configs.excel2json.lua_siege_battle_word", package.seeall)

local lua_siege_battle_word = {}
local fields = {
	id = 1,
	sign = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_siege_battle_word.onLoad(json)
	lua_siege_battle_word.configList, lua_siege_battle_word.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_siege_battle_word
