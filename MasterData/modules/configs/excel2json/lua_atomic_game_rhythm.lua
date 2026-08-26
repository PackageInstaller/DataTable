-- chunkname: @modules/configs/excel2json/lua_atomic_game_rhythm.lua

module("modules.configs.excel2json.lua_atomic_game_rhythm", package.seeall)

local lua_atomic_game_rhythm = {}
local fields = {
	point = 2,
	time = 3,
	id = 1,
	title = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_game_rhythm.onLoad(json)
	lua_atomic_game_rhythm.configList, lua_atomic_game_rhythm.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_game_rhythm
