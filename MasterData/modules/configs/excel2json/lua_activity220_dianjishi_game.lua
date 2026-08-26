-- chunkname: @modules/configs/excel2json/lua_activity220_dianjishi_game.lua

module("modules.configs.excel2json.lua_activity220_dianjishi_game", package.seeall)

local lua_activity220_dianjishi_game = {}
local fields = {
	mapIcon = 3,
	startPos = 4,
	mapScale = 5,
	areaSplitSize = 6,
	targetDesc = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}

function lua_activity220_dianjishi_game.onLoad(json)
	lua_activity220_dianjishi_game.configList, lua_activity220_dianjishi_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_dianjishi_game
