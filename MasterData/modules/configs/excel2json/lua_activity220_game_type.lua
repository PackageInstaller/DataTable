-- chunkname: @modules/configs/excel2json/lua_activity220_game_type.lua

module("modules.configs.excel2json.lua_activity220_game_type", package.seeall)

local lua_activity220_game_type = {}
local fields = {
	gameType = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {}

function lua_activity220_game_type.onLoad(json)
	lua_activity220_game_type.configList, lua_activity220_game_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_game_type
