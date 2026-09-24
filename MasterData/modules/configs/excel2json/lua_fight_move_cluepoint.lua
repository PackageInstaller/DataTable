-- chunkname: @modules/configs/excel2json/lua_fight_move_cluepoint.lua

module("modules.configs.excel2json.lua_fight_move_cluepoint", package.seeall)

local lua_fight_move_cluepoint = {}
local fields = {
	heroId = 2,
	cluepoint = 1,
	facetsId = 3
}
local primaryKey = {
	"cluepoint"
}
local mlStringKey = {}

function lua_fight_move_cluepoint.onLoad(json)
	lua_fight_move_cluepoint.configList, lua_fight_move_cluepoint.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_move_cluepoint
