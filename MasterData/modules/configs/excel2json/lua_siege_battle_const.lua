-- chunkname: @modules/configs/excel2json/lua_siege_battle_const.lua

module("modules.configs.excel2json.lua_siege_battle_const", package.seeall)

local lua_siege_battle_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_siege_battle_const.onLoad(json)
	lua_siege_battle_const.configList, lua_siege_battle_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_siege_battle_const
