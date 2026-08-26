-- chunkname: @modules/configs/excel2json/lua_atomic_game_color.lua

module("modules.configs.excel2json.lua_atomic_game_color", package.seeall)

local lua_atomic_game_color = {}
local fields = {
	outerPoint = 2,
	innerPoint = 3,
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

function lua_atomic_game_color.onLoad(json)
	lua_atomic_game_color.configList, lua_atomic_game_color.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_game_color
