-- chunkname: @modules/configs/excel2json/lua_auto_chess_enemy.lua

module("modules.configs.excel2json.lua_auto_chess_enemy", package.seeall)

local lua_auto_chess_enemy = {}
local fields = {
	id = 1,
	masterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_enemy.onLoad(json)
	lua_auto_chess_enemy.configList, lua_auto_chess_enemy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_enemy
