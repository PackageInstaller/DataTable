-- chunkname: @modules/configs/excel2json/lua_activity220_lamona_game.lua

module("modules.configs.excel2json.lua_activity220_lamona_game", package.seeall)

local lua_activity220_lamona_game = {}
local fields = {
	mapId = 2,
	propCount = 5,
	propId = 4,
	targetDesc = 3,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}

function lua_activity220_lamona_game.onLoad(json)
	lua_activity220_lamona_game.configList, lua_activity220_lamona_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_lamona_game
