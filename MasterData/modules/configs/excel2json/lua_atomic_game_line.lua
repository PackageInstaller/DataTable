-- chunkname: @modules/configs/excel2json/lua_atomic_game_line.lua

module("modules.configs.excel2json.lua_atomic_game_line", package.seeall)

local lua_atomic_game_line = {}
local fields = {
	desc = 5,
	targetType = 3,
	id = 1,
	title = 4,
	shootType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_atomic_game_line.onLoad(json)
	lua_atomic_game_line.configList, lua_atomic_game_line.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_game_line
