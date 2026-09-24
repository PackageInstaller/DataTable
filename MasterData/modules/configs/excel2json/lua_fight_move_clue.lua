-- chunkname: @modules/configs/excel2json/lua_fight_move_clue.lua

module("modules.configs.excel2json.lua_fight_move_clue", package.seeall)

local lua_fight_move_clue = {}
local fields = {
	facetsId = 3,
	heroId = 2,
	clueId = 1
}
local primaryKey = {
	"clueId"
}
local mlStringKey = {}

function lua_fight_move_clue.onLoad(json)
	lua_fight_move_clue.configList, lua_fight_move_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_move_clue
