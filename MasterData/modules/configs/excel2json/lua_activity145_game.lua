-- chunkname: @modules/configs/excel2json/lua_activity145_game.lua

module("modules.configs.excel2json.lua_activity145_game", package.seeall)

local lua_activity145_game = {}
local fields = {
	id = 1,
	value1 = 2,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity145_game.onLoad(json)
	lua_activity145_game.configList, lua_activity145_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity145_game
