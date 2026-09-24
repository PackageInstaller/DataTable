-- chunkname: @modules/configs/excel2json/lua_fight_move_skillgroup.lua

module("modules.configs.excel2json.lua_fight_move_skillgroup", package.seeall)

local lua_fight_move_skillgroup = {}
local fields = {
	slot = 2,
	effect = 4,
	skillgroup = 5,
	id = 1,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_move_skillgroup.onLoad(json)
	lua_fight_move_skillgroup.configList, lua_fight_move_skillgroup.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_move_skillgroup
