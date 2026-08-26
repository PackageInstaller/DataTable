-- chunkname: @modules/configs/excel2json/lua_activity210_game.lua

module("modules.configs.excel2json.lua_activity210_game", package.seeall)

local lua_activity210_game = {}
local fields = {
	battleGroup = 3,
	mapId = 2,
	gameTarget = 4,
	battleTime = 7,
	loseTarget = 5,
	skill = 6,
	battledesc = 8,
	targetDesc = 9,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {}

function lua_activity210_game.onLoad(json)
	lua_activity210_game.configList, lua_activity210_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity210_game
