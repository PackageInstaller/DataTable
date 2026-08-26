-- chunkname: @modules/configs/excel2json/lua_boss_fight_mode_const.lua

module("modules.configs.excel2json.lua_boss_fight_mode_const", package.seeall)

local lua_boss_fight_mode_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_boss_fight_mode_const.onLoad(json)
	lua_boss_fight_mode_const.configList, lua_boss_fight_mode_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_boss_fight_mode_const
