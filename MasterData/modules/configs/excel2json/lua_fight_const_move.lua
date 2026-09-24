-- chunkname: @modules/configs/excel2json/lua_fight_const_move.lua

module("modules.configs.excel2json.lua_fight_const_move", package.seeall)

local lua_fight_const_move = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_const_move.onLoad(json)
	lua_fight_const_move.configList, lua_fight_const_move.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_const_move
