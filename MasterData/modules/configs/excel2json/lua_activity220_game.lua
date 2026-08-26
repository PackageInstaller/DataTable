-- chunkname: @modules/configs/excel2json/lua_activity220_game.lua

module("modules.configs.excel2json.lua_activity220_game", package.seeall)

local lua_activity220_game = {}
local fields = {
	winText = 5,
	baseAttr = 6,
	background = 2,
	levelDay = 3,
	position = 4,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {}

function lua_activity220_game.onLoad(json)
	lua_activity220_game.configList, lua_activity220_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_game
