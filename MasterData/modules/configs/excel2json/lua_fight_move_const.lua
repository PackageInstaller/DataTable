-- chunkname: @modules/configs/excel2json/lua_fight_move_const.lua

module("modules.configs.excel2json.lua_fight_move_const", package.seeall)

local lua_fight_move_const = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_move_const.onLoad(json)
	lua_fight_move_const.configList, lua_fight_move_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_move_const
