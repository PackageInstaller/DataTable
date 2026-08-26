-- chunkname: @modules/configs/excel2json/lua_atomic_avg_game.lua

module("modules.configs.excel2json.lua_atomic_avg_game", package.seeall)

local lua_atomic_avg_game = {}
local fields = {
	id = 1,
	content = 2,
	storyId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_atomic_avg_game.onLoad(json)
	lua_atomic_avg_game.configList, lua_atomic_avg_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_avg_game
